/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.jvm.stats;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.Socket;

/**
 * @author amatevos
 */
public class JVMStatsTest {

	/* send jvm stats, for testing */
	public static void main(String[] args)
	{
		String host = "192.168.56.1";
		int port = 2003;
		Socket obj = null;
		Writer writer = null;

		try {
			//send 10 data points
			for (int j=0; j<1; j++)
			{
				obj = new Socket(host, port);
				writer = new OutputStreamWriter(obj.getOutputStream(), "UTF-8");
				Long time = System.currentTimeMillis() / 1000;
				
				/* send jvm stats */
				String dataPrefix = "ara-laptop64.server001.server001_13.JVM.";
				IJVMStatistics ijs = JVMStatisticsFactory.getJVMStatisticsImpl();
				writeToGraphite(writer, getData(dataPrefix+"UsedMemory", ijs.getUsedMemory(), time));
				writeToGraphite(writer, getData(dataPrefix+"TotalMemory", ijs.getTotalMemory(), time));
					
				writeToGraphite(writer, getData(dataPrefix+"GarbageCollectionNumber", ijs.getGCCount(), time));
				writeToGraphite(writer, getData(dataPrefix+"GarbageCollectionTime", ijs.getGCTime(), time));
			}
			
		} catch (Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	private static void writeToGraphite(Writer writer, String data) throws IOException
	{
		System.out.println(data);
		//writer.write(data);
		//writer.flush();
	}
	
	public static String getData(String name, Long value, Long time) {
		return new StringBuilder().append(name).append(" ").append(value).append(" ").append(time).append("\n").toString();
	}

}
