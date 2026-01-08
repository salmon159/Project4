/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import com.ibm.sterling.sample.graphite.category.CustomCategory;
import com.ibm.sterling.sample.graphite.category.DefaultCategory;

public final class ExporterConfig {
	private static final String propFile = "graphite-exporter.properties";
	
	private static ExporterConfig _instance = null;
	
	String commonPrefix="";
	Client client = null;
	private ExporterConfig() throws GraphiteClientConfigurationException {
		try {
			Properties cfg = loadProps();
			Logger.setVerbose(Boolean.valueOf(cfg.getProperty("logging.verbose", "false")));
			
			client = ClientFactory.getClient(cfg);
			
			String commonPrefix = cfg.getProperty("metrics.common.prefix");
			if (!Utils.isVoid(commonPrefix))
				this.commonPrefix = commonPrefix.trim() + ".";
		
			loadCategories(cfg);
		} catch (IOException e) {
			throw new GraphiteClientConfigurationException("Exception occurred while initializing configuration", e);
		}
	}

	private void loadCategories(Properties cfg) throws GraphiteClientConfigurationException {
		// load the default category
		loadCategory(cfg, "default");
		
		// load custom categories
		String categories = cfg.getProperty("statistics.categories");
		for (String cat : categories.split(",")) {
			cat = cat.trim();
			if (Utils.isVoid(cat))
				Logger.warn("Skipping blank category declaration");
			else 
				loadCategory(cfg, cat);
		}
	}

	private void loadCategory(Properties cfg, String cat) throws GraphiteClientConfigurationException {
		if (cat.trim().equals("default")) {
			DefaultCategory.createAndRegister(readCategoryConfig("digests", cfg, cat), readCategoryConfig("prefix", cfg, cat));
		} else {
			CustomCategory.createAndRegister(
					cat, 
					readCategoryConfig("statnames", cfg, cat), 
					readCategoryConfig("digests", cfg, cat), 
					readCategoryConfig("prefix", cfg, cat));
		}
	}
	
	private String readCategoryConfig(String confname, Properties cfg, String cat) {
		return cfg.getProperty("statistics.category."+cat+"."+confname);
	}

	@SuppressWarnings("serial")
	private Properties loadProps() throws IOException, GraphiteClientConfigurationException {
		final InputStream propstr = ExporterConfig.class.getClassLoader().getResourceAsStream(propFile);
		if (propstr == null) throw new GraphiteClientConfigurationException("Property file: " + propFile + " not found in classpath");
		return new Properties(){{load(propstr);}};
	}

	public static synchronized ExporterConfig getInstance() throws GraphiteClientConfigurationException {
		if (_instance == null) {
			_instance = new ExporterConfig();
		}
		return _instance;
	}

	public String getCommonPrefix() {
		return commonPrefix;
	}

	public Client getClient() {
		return client;
	}
}
