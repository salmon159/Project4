VERSION 5.00
Begin VB.Form mainForm 
   Caption         =   "Form1"
   ClientHeight    =   8520
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9405
   LinkTopic       =   "Form1"
   ScaleHeight     =   8520
   ScaleWidth      =   9405
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtURL 
      Height          =   375
      Left            =   4800
      TabIndex        =   8
      Text            =   "http://localhost:7001"
      Top             =   120
      Width           =   3615
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Exit"
      Height          =   375
      Left            =   5880
      TabIndex        =   7
      Top             =   8040
      Width           =   1695
   End
   Begin VB.TextBox txtOutXML 
      Height          =   3135
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   6
      Top             =   4800
      Width           =   9015
   End
   Begin VB.TextBox txtAPIName 
      Height          =   375
      Left            =   1320
      TabIndex        =   2
      Top             =   120
      Width           =   2055
   End
   Begin VB.TextBox txtInXML 
      Height          =   2775
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   1200
      Width           =   8895
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Execute"
      Height          =   375
      Left            =   3360
      TabIndex        =   0
      Top             =   8040
      Width           =   1815
   End
   Begin VB.Label Label4 
      Caption         =   "URL"
      Height          =   375
      Left            =   4200
      TabIndex        =   9
      Top             =   120
      Width           =   495
   End
   Begin VB.Label Label3 
      Caption         =   "OutputXML"
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   4440
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "InputXML"
      Height          =   375
      Left            =   240
      TabIndex        =   4
      Top             =   720
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "FlowName"
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   120
      Width           =   975
   End
End
Attribute VB_Name = "mainForm"
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

Dim WinHttpReq As WinHttp.WinHttpRequest

Private Sub Command2_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    ' Create an instance of the WinHTTPRequest ActiveX object.
    Set WinHttpReq = New WinHttpRequest
End Sub

Private Sub Command1_Click()
    ' Create an array to hold the response data.
    Dim d() As Byte
    Dim userId As String
    Dim progId As String
    Dim apiName As String
    Dim systemName As String
    Dim adapterName As String
    Dim xml As String
    Dim sendData As String
    Dim url As String
    
    
    userId = "admin"
    progId = "Migrator"
    apiName = txtAPIName.Text
    url = txtURL.Text
    
    xml = txtInXML.Text
    
    sendData = "YFSEnvironment.userId=" + userId + "&YFSEnvironment.progId=" _
        + progId + "&InteropApiName=" + apiName _
        + "&InteropApiData=" + xml + "&IsFlow=Y"
    
    'MsgBox sendData
    url = url + "/yantra/interop/InteropHttpServlet"
    
'    WinHttpReq.Open "POST", _
 '       "http://localhost:7001/yantra/interop/InteropHttpServlet", False
    WinHttpReq.Open "POST", url, False

    ' Send the HTTP Request.

    WinHttpReq.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
    WinHttpReq.SetRequestHeader "Content-Length", Len(sendData)
    
        
    WinHttpReq.Send sendData
    
    txtOutXML.Text = WinHttpReq.ResponseText
End Sub

