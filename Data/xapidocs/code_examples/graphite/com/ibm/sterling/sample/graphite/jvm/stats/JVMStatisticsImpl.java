/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.jvm.stats;

import java.lang.management.GarbageCollectorMXBean;
import java.lang.management.ManagementFactory;

/**
 * @author amatevos
 */
public class JVMStatisticsImpl implements IJVMStatistics{

	private static final long MEGABYTE = 1024L * 1024L;	
	long totalGarbageCollections = 0;
    long garbageCollectionTime = 0; //milliseconds
    
    public JVMStatisticsImpl() {
    	computeGCStats();
    }
    
	public void computeGCStats() {
	    for(GarbageCollectorMXBean gc :
	            ManagementFactory.getGarbageCollectorMXBeans()) {

	        long count = gc.getCollectionCount();

	        if(count >= 0) {
	            totalGarbageCollections += count;
	        }

	        long time = gc.getCollectionTime();

	        if(time >= 0) {
	            garbageCollectionTime += time;
	        }
	    }
	}

	@Override
	public long getUsedMemory() {
		Runtime runtime = Runtime.getRuntime();
		
		// Calculate the used memory
	    return getTotalMemory() - (runtime.freeMemory() / MEGABYTE);
	}

	@Override
	public long getTotalMemory() {
		Runtime runtime = Runtime.getRuntime();
		
		// Calculate the used memory
	    return runtime.totalMemory() / MEGABYTE;
	}

	@Override
	public long getGCCount() {
		return totalGarbageCollections;
	}

	@Override
	public long getGCTime() {
		return garbageCollectionTime;
	}
}
