' This is VBScript.
' 参照サイトは以下
' http://homepage2.nifty.com/nonnon/Chinamini/20100001/20101012.html
' WSHリファレンスは以下
' http://wsh.style-mods.net/
' フォルダ内のファイル一覧
Redim path_list(0)
Dim WSH
Set WSH = WScript.CreateObject("WScript.Shell")

' =============================== 作業対象フォルダの指定
'GetFData "C:\Users\username\Desktop"
'GetFData "C:\Users\username\Documents\anywhere"
' スペシャルフォルダに切り替えパターン これを指定すればログインユーザに切り替わる
GetFData WSH.SpecialFolders("Desktop"), path_list
' デバック用
FListWrite WSH.SpecialFolders("Desktop") & "\" & "lnkchange_log.txt", path_list

' フォルダ内のファイル一覧を表示する
Public Sub GetFData(ByVal fol_path, ByRef path_list())
	Dim LnkFile, objNetWork, NewUserFolderPath, OldUserFolderPath
	
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set objNetWork = WScript.CreateObject("WScript.Network")

	' UserFolderの変更対応
	OldUserFolderPath = "C:\Users\" & objNetWork.UserName
	NewUserFolderPath = "C:\Users\" & objNetWork.UserName & "." & objNetWork.UserDomain
	Msgbox "Old :" & OldUserFolderPath & " New :" & NewUserFolderPath
	
	For Each f In fso.GetFolder(fol_path).files
	
		If LCase(FSO.GetExtensionName(f.Name)) = "lnk" Then
			' WSHのCreateShortcutでショートカットオブジェクトを取得
			' Set LnkFile = WSH.CreateShortcut(fso.GetFolder(fol_path) & "\" & f.Name)
			Set LnkFile = WSH.CreateShortcut(f.Path)

			If InStrRev(LnkFile.TargetPath, OldUserFolderPath) > 0 Then	

				ReDim Preserve path_list(UBound(path_list) + 1)
				path_list(UBound(path_list)) = f.path  & vbTab & LnkFile.TargetPath
				
				LnkFile.TargetPath =  Replace(LnkFile.TargetPath, objNetWork.UserName, objNetWork.UserName & "." & objNetWork.UserDomain)
				LnkFile.save
			End If
				
		End If
	
	Next ' GetFolderの終了
	
	Msgbox "処理は終了です。お疲れ様でした。"
	Set LnkFile = Nothing
	Set objNetWork = Nothing
	
End Sub


' フォルダ内のファイル一覧をファイルに出力 対象ファイルを出力するためのデバックとして使用
Private Sub FListWrite(ByVal out_path, ByRef path_list())
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set txf = fso.CreateTextFile(out_path, True)
	For i = 1 To UBound(path_list)
		 txf.WriteLine path_list(i)
	Next
	txf.Close
	Set txf = Nothing
	Set fso = Nothing

End Sub



