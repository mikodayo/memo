' This is VBScript.
' �Q�ƃT�C�g�͈ȉ�
' http://homepage2.nifty.com/nonnon/Chinamini/20100001/20101012.html
' WSH���t�@�����X�͈ȉ�
' http://wsh.style-mods.net/
' �t�H���_���̃t�@�C���ꗗ
Redim path_list(0)
Dim WSH
Set WSH = WScript.CreateObject("WScript.Shell")

' =============================== ��ƑΏۃt�H���_�̎w��
'GetFData "C:\Users\username\Desktop"
'GetFData "C:\Users\username\Documents\anywhere"
' �X�y�V�����t�H���_�ɐ؂�ւ��p�^�[�� ������w�肷��΃��O�C�����[�U�ɐ؂�ւ��
GetFData WSH.SpecialFolders("Desktop"), path_list
' �f�o�b�N�p
FListWrite WSH.SpecialFolders("Desktop") & "\" & "lnkchange_log.txt", path_list

' �t�H���_���̃t�@�C���ꗗ��\������
Public Sub GetFData(ByVal fol_path, ByRef path_list())
	Dim LnkFile, objNetWork, NewUserFolderPath, OldUserFolderPath
	
	Set fso = CreateObject("Scripting.FileSystemObject")
	Set objNetWork = WScript.CreateObject("WScript.Network")

	' UserFolder�̕ύX�Ή�
	OldUserFolderPath = "C:\Users\" & objNetWork.UserName
	NewUserFolderPath = "C:\Users\" & objNetWork.UserName & "." & objNetWork.UserDomain
	Msgbox "Old :" & OldUserFolderPath & " New :" & NewUserFolderPath
	
	For Each f In fso.GetFolder(fol_path).files
	
		If LCase(FSO.GetExtensionName(f.Name)) = "lnk" Then
			' WSH��CreateShortcut�ŃV���[�g�J�b�g�I�u�W�F�N�g���擾
			' Set LnkFile = WSH.CreateShortcut(fso.GetFolder(fol_path) & "\" & f.Name)
			Set LnkFile = WSH.CreateShortcut(f.Path)

			If InStrRev(LnkFile.TargetPath, OldUserFolderPath) > 0 Then	

				ReDim Preserve path_list(UBound(path_list) + 1)
				path_list(UBound(path_list)) = f.path  & vbTab & LnkFile.TargetPath
				
				LnkFile.TargetPath =  Replace(LnkFile.TargetPath, objNetWork.UserName, objNetWork.UserName & "." & objNetWork.UserDomain)
				LnkFile.save
			End If
				
		End If
	
	Next ' GetFolder�̏I��
	
	Msgbox "�����͏I���ł��B�����l�ł����B"
	Set LnkFile = Nothing
	Set objNetWork = Nothing
	
End Sub


' �t�H���_���̃t�@�C���ꗗ���t�@�C���ɏo�� �Ώۃt�@�C�����o�͂��邽�߂̃f�o�b�N�Ƃ��Ďg�p
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



