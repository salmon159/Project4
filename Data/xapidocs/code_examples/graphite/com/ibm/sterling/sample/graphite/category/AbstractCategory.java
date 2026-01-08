/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.category;

import java.util.ArrayList;
import java.util.List;

import com.ibm.sterling.sample.graphite.GraphiteClientConfigurationException;
import com.ibm.sterling.sample.graphite.Digest;
import com.ibm.sterling.sample.graphite.GraphiteExporterException;
import com.ibm.sterling.sample.graphite.Logger;
import com.ibm.sterling.sample.graphite.Utils;
import com.ibm.sterling.sample.graphite.digests.DigestRegistry;

public abstract class AbstractCategory implements Category{
	protected String name;
	protected String digests;
	protected String prefix;
	
	protected List<Class<? extends Digest<?>>> digestClasses = new ArrayList<>();
	public AbstractCategory(String name, String digests, String prefix) throws GraphiteClientConfigurationException {
		this.name = name;
		this.digests = digests;
		if (Utils.isVoid(digests)) 
			throw new GraphiteClientConfigurationException("Digests for the category '" + name + "' needs to be specified");
		processDigests();
		if (!Utils.isVoid(prefix))
			this.prefix = prefix.trim() + ".";
		else 
			this.prefix = "";
	}
	private void processDigests() throws GraphiteClientConfigurationException {
		for (String digest : digests.split(",")) {
			digest = digest.trim();
			if (Utils.isVoid(digest))
				Logger.warn("Skipping empty sub-string in digests configuration for category: " + name);
			else 
				digestClasses.add(DigestRegistry.getDigestForName(digest));
		}
		if (digestClasses.size() == 0) 
			throw new GraphiteClientConfigurationException("No digests configured for category: " + name);
	}
	
	public List<Digest<?>> generateDigests() {
		List<Digest<?>> retval = new ArrayList<>();
		for (Class<? extends Digest<?>> digestClass : digestClasses) {
			try {
				retval.add(digestClass.newInstance());
			} catch (InstantiationException | IllegalAccessException e) {
				throw new RuntimeException(new GraphiteExporterException("Unexpected exception encountered", e));
			}
		}
		return retval;
	}
	
	public String getName() {
		return name;
	}
	
	public String getPrefix() {
		return prefix;
	}
}
