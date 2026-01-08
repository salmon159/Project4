/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite.jvm.stats;


/**
 * @author amatevos
 * 
 * Interface for sending JVM statistics
 */
public interface IJVMStatistics {
		
		/**
		 * @return Used JVM Memory in MB
		 */
		public long getUsedMemory();
		
		/**
		 * @return Total JVM Memory in MB
		 */
		public long getTotalMemory();
		
		/**
		 * @return Total number of GC cycles that have been performed. 
		 */
		public long getGCCount();
		
		/** 
		 * @return TotalGarbageCollectionTime in milliseconds
		 */
		public long getGCTime();

}
