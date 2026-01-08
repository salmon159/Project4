VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   8070
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9660
   LinkTopic       =   "Form1"
   ScaleHeight     =   8070
   ScaleWidth      =   9660
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtAPIName 
      Enabled         =   0   'False
      Height          =   375
      Left            =   2160
      TabIndex        =   7
      Text            =   "getOrganizationList"
      Top             =   120
      Width           =   2655
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "E&xit"
      Height          =   375
      Left            =   8160
      TabIndex        =   6
      Top             =   7560
      Width           =   1335
   End
   Begin VB.TextBox txtOutXml 
      Height          =   2055
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   3
      Text            =   "VBApiCall.frx":0000
      Top             =   5280
      Width           =   9375
   End
   Begin VB.TextBox txtInXML 
      Height          =   3615
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   1
      Text            =   "VBApiCall.frx":001D
      Top             =   1200
      Width           =   9375
   End
   Begin VB.CommandButton Command1 
      Caption         =   "E&xecute API"
      Height          =   375
      Left            =   6120
      TabIndex        =   0
      Top             =   7560
      Width           =   1815
   End
   Begin VB.Label Label3 
      Caption         =   "Select API to Execute"
      Height          =   375
      Left            =   0
      TabIndex        =   5
      Top             =   120
      Width           =   1695
   End
   Begin VB.Label Label2 
      Caption         =   "OutPut XML"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   4920
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "Input XML for getATP"
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   840
      Width           =   2415
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Licensed Materials - Property of IBM
' IBM Sterling Selling and Fulfillment Suite
' (C) Copyright IBM Corp. 2001, 2013 All Rights Reserved.
' US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
'
'                     LIMITATION OF LIABILITY
' THIS SOFTWARE SAMPLE IS PROVIDED "AS IS" AND ANY EXPRESSED OR IMPLIED
' WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
' MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
' IN NO EVENT SHALL STERLING COMMERCE, Inc. BE LIABLE UNDER ANY THEORY OF
' LIABILITY (INCLUDING, BUT NOT LIMITED TO, BREACH OF CONTRACT, BREACH
' OF WARRANTY, TORT, NEGLIGENCE, STRICT LIABILITY, OR ANY OTHER THEORY
' OF LIABILITY) FOR (i) DIRECT DAMAGES OR INDIRECT, SPECIAL, INCIDENTAL,
' OR CONSEQUENTIAL DAMAGES SUCH AS, BUT NOT LIMITED TO, EXEMPLARY OR
' PUNITIVE DAMAGES, OR ANY OTHER SIMILAR DAMAGES, WHETHER OR NOT
' FORESEEABLE AND WHETHER OR NOT STERLING OR ITS REPRESENTATIVES HAVE
' BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES, OR (ii) ANY OTHER
' CLAIM, DEMAND OR DAMAGES WHATSOEVER RESULTING FROM OR ARISING OUT OF
' OR IN CONNECTION THE DELIVERY OR USE OF THIS INFORMATION.

Private Sub cmdExit_Click()
    Unload Me
End Sub

 Private Sub Command1_Click()
    Dim api As Object
    Dim inXml As String
    Dim env As Variant
    Dim errXml As Variant
    Dim retVal As Variant
    Dim outXml As Variant
       
    Screen.MousePointer = 11
    inXml = txtInXML.Text
    Set api = New YIFComApi

    retVal = api.createEnvironment(env, "yantra", "yantra")
    retVal = api.getOrganizationList(env, inXml, outXml, errXml)
    'retVal = api.executeFlow(env, "TestService", inXml, outXml, errXml)
            
    If retVal = 0 Then
        txtOutXml.Text = outXml + "test1"
    Else
        txtOutXml.Text = errXml + "testErr"
    End If
    Set api = Nothing
    
    Screen.MousePointer = 0
End Sub

Private Sub Command2_Click()
End Sub

Private Sub txtInXML_Change()

End Sub
