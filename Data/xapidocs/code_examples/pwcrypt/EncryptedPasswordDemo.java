/*
 * IBM Confidential 
 *
 * OCO Source Materials
 *
 * IBM Sterling Selling and Fullfillment Suite
 *
 * (c) Copyright IBM Corp. 2001, 2013 All Rights Reserved.
 *
 * The source code for this program is not published or otherwise divested of its trade secrets,
 * irrespective of what has been deposited with the U.S. Copyright Office.
 */

package com.yantra.test;

import java.math.BigInteger;
import java.security.MessageDigest;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.yantra.ycp.japi.ue.YCPCheckPasswordsMatchUE;
import com.yantra.ycp.japi.ue.YCPValidateChangedPasswordUE;
import com.yantra.yfs.japi.YFSEnvironment;
import com.yantra.yfs.japi.YFSUserExitException;

/**
 * Sample implementation of password-related user exits.
 * This example stores MD5 hashes of passwords in the database and validates
 * that all new passwords are at least eight characters long and contain at
 * least one upper-case letter and one lower-case letter.
 */
public class EncryptedPasswordDemo implements YCPValidateChangedPasswordUE,
        YCPCheckPasswordsMatchUE {

    
    /**
     * Hashes the given string with MD5, returning a hex representation of it.
     * @param str String to create the digest of.
     * @return Digest of the input, in hexadecimal format.
     */
    private String getDigest(String str) {
        try {
            // First get the digest.
            byte[] buffer = str.getBytes("UTF-8");
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(buffer);
            byte[] digest = md5.digest();
            
            // Then convert the digest into String form, suitable for XML attribute values.
            BigInteger bi = new BigInteger(1, digest);
            String hex = bi.toString(16);
            if( hex.length() % 2 != 0 ) { // Possibly pad a leading zero.
                hex = "0" + hex;
            }
            return hex;
        } catch(Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    /**
     * Validates the new password and returns an MD5 digest of it.
     */
    public Document validateChangedPassword(YFSEnvironment env, Document inXML)
            throws YFSUserExitException {
        Element root = inXML.getDocumentElement();
        String pass = root.getAttribute("NewPassword");
        if( pass == null
                || pass.length() < 8
                || pass.equals(pass.toLowerCase())
                || pass.equals(pass.toUpperCase()) ) {
            throw new YFSUserExitException("EXTN_InvalidPass");
        }
        
        root.setAttribute("Password", getDigest(pass));
        return inXML;
    }

    /**
     * Checks that the given password matches the password in the database.
     */
    public Document checkPasswordsMatch(YFSEnvironment env, Document inXML)
            throws YFSUserExitException {
        Element root = inXML.getDocumentElement();
        String existingPassword = root.getAttribute("ExistingPassword");
        String givenPassword = root.getAttribute("GivenPassword");
        boolean match = false;
        if( existingPassword != null && givenPassword != null ) {
            String digest = getDigest(givenPassword);
            match = existingPassword.equals(digest);
        }
        
        root.setAttribute("PasswordsMatch", match ? "Y" : "N");
        return inXML;
    }

}
