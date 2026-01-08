/*******************************************************************************
 * IBM Confidential
 * OCO Source Materials
 * 5725-D10
 * (C) Copyright IBM Corp. 2015, 2016
 *******************************************************************************/
package com.ibm.sterling.sample.graphite;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.net.UnknownHostException;

/**
 * This class is stateful. To initiate a connection, {@link #init()} needs to be called, 
 * which creates a socket and opens an output stream to write to the socket. The {@link #write(String)}
 * method allows for the client to write to the stream. Once finished, {@link #close()} needs to 
 * be called to flush the data and close the stream. 
 * 
 * @author sri
 */
public class GraphiteClient implements Client {
	private static final String charset = "UTF-8";
	
	String host;
	int port;
	GraphiteClient(String host, int port) {
		this.host = host;
		this.port = port;
	}
	
	Socket socket = null;
	OutputStreamWriter writer = null;
	/*
	 * A call to this method needs to be followed up with a call to close
	 */
	public void init() throws UnknownHostException, IOException {
		socket = new Socket(host, port);
		writer = new OutputStreamWriter(socket.getOutputStream(), charset);
	}
	
	public void write(String payload) throws IOException {
		Logger.verbose("Writing payload to graphite: " + payload);
		writer.write(payload);
	}
	
	public void flush() throws IOException {
		writer.flush();
	}
	
	public void close() throws IOException {
		flush();
		writer.close();
		socket.close();
	}
}
