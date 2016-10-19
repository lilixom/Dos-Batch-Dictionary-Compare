<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PreviewFile.aspx.cs" Inherits="TAP.Web.Workflow.App.OfficeOnline.PreviewFile" %>

<!DOCTYPE html>

<html class="html-ocx" xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="StyleSheet.css" rel="stylesheet" />
    <style type="text/css">
        .html-ocx, .html-ocx > body {
            background-color: transparent;
        }

            .html-ocx, .html-ocx > body, .html-ocx form, #officecontrol {
                height: 100%;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="attachPath" value="<%=attachPath %>" />
        <input type="hidden" id="attachName" value="<%=attachName %>" />
        <div id="officecontrol">
            <!--引用NTKO OFFICE文档控件-->
            <object id="TANGER_OCX" classid="clsid:C39F1330-3322-4a1d-9BF0-0BA2BB90E970" codebase="OfficeControl.cab#version=5,0,2,7" style="width: 100%; height: 100%; margin: 0px; position: relative;">
                <param name="MakerCaption" value="福州特力惠电子有限公司" />
                <param name="MakerKey" value="B7DB8F50B4ADEB2D410B5165257C39EE320F6167" />
                <param name="ProductCaption" value="河北国土电子政务" />
                <param name="ProductKey" value="B1051EC4981B32644BA1058B6356A40E436C309D" />

                <param name="IsUseUTF8URL" value="-1" />
                <param name="IsUseUTF8Data" value="-1" />
                <param name="BorderStyle" value="1" />
                <param name="BorderColor" value="14402205" />
                <param name="TitlebarColor" value="15658734" />
                <param name="TitlebarTextColor" value="0" />
                <param name="MenubarColor" value="14402205" />
                <param name="MenuButtonColor" value="16180947" />
                <param name="MenuBarStyle" value="3" />
                <param name="MenuButtonStyle" value="7" />
                <param name="WebUserName" value="" />
                <param name="Caption" value="" />
                <span style="color: red;">不能装载文档控件。请确认你可以连接网络或者检查浏览器的选项中安全设置。</span>
            </object>
        </div>
    </form>
</body>
<script type="text/javascript">
    var TANGER_OCX_OBJ = document.getElementById("TANGER_OCX");

    var filePath = document.getElementById('attachPath').value
    var attachName = document.getElementById('attachName').value;
    var fileUrl = "/Handler/FileDownload.ashx?attachPath=" + encodeURI(filePath) + "&attachName=" + attachName;
    var fileName = document.getElementById('attachName').value;
    if (TANGER_OCX_OBJ) {
        TANGER_OCX_OBJ = document.getElementById("TANGER_OCX");//;初始化控件对象
        TANGER_OCX_OBJ.IsShowFileErrorMsg = false;
        TANGER_OCX_OBJ.AddDocTypePlugin(".tiff", "TIF.NtkoDocument", "4.0.0.5", "ntkooledocall.cab", 51);
        TANGER_OCX_OBJ.AddDocTypePlugin(".ntkf", "NTKF.NtkoDocument", "4.0.0.5", "ntkooledocall.cab", 52);
        TANGER_OCX_OBJ.AddDocTypePlugin(".pdf", "PDF.NtkoDocument", "4.0.0.5", "ntkooledocall.cab", 53);
        TANGER_OCX_OBJ.Menubar = true; //菜单行
        TANGER_OCX_OBJ.TitleBar = false; //标题行
        TANGER_OCX_OBJ.IsShowInsertMenu = true;
        TANGER_OCX_OBJ.IsShowEditMenu = true;
        TANGER_OCX_OBJ.IsShowToolMenu = true;
        TANGER_OCX_OBJ.FileSave = false;
        TANGER_OCX_OBJ.FileSaveAs = false;
        TANGER_OCX_OBJ.FileClose = false;
        TANGER_OCX_OBJ.FileOpen = false;
        TANGER_OCX_OBJ.FileNew = false;
        TANGER_OCX_OBJ.FileProperties = false; //设置属性菜单
        //根据文档URL和newofficetype编辑文档,如果有url是编辑已有文档,如果为空根据newofficetype新建文档
        try {
            TANGER_OCX_OBJ.OpenFromURL(fileUrl);
        } catch (err) {
            alert(TANGER_OCX_OBJ.StatusMessage + "[文件名称:" + filename + "]");
        }
    }
</script>
</html>