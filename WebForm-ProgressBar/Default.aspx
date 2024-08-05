<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebForm_ProgressBar._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style="width: 100%; background-color: #f3f3f3; border-radius: 5px; overflow: hidden;">
        <div id="progressBar" style="width: 0%; height: 30px; background-color: #4caf50; text-align: center; line-height: 30px; color: white; border-radius: 5px;">
            1
        </div>
    </div>
    <br />
    <button type="button" onclick="startProgress()">Start Progress</button>

    <script type="text/javascript">
        var isProgressing = false; 
        var maxProgress = 69;
        var stepTime = 100;

        function startProgress() {
            if (isProgressing) return;

            isProgressing = true;
            var elem = document.getElementById("progressBar");
            var width = 1;
            elem.innerHTML = width;
            elem.style.width = (width / maxProgress) * 100 + '%';

            var interval = setInterval(function () {
                if (width >= maxProgress) {
                    clearInterval(interval);
                    isProgressing = false; 
                } else {
                    width++;
                    elem.innerHTML = width; 
                    elem.style.width = (width / maxProgress) * 100 + '%'; 
                }
            }, stepTime);
        }
    </script>
</asp:Content>
