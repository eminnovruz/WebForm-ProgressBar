<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebForm_ProgressBar._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style="width: 100%; background-color: #f3f3f3; border-radius: 5px; overflow: hidden;">
        <div id="progressBar" style="width: 0%; height: 30px; background-color: #4caf50; text-align: center; line-height: 30px; color: white; border-radius: 5px;">
            1
        </div>
    </div>
    <br />
    <button type="button" onclick="startProgress()">Start Progress</button>
    <br /><br />
    <div id="timer">Elapsed Time: 0s</div>

    <script type="text/javascript">
        var isProgressing = false; 
        var maxProgress = 100;
        var stepTime = 100;
        var startTime; 
        var timerInterval; 

        function startProgress() {
            if (isProgressing) return;

            isProgressing = true; 
            var elem = document.getElementById("progressBar");
            var timerElem = document.getElementById("timer");
            var width = 1;
            elem.innerHTML = width; 
            elem.style.width = (width / maxProgress) * 100 + '%';

            startTime = new Date();

            timerInterval = setInterval(updateTimer, 100);

            var interval = setInterval(function () {
                if (width >= maxProgress) {
                    clearInterval(interval);
                    clearInterval(timerInterval); 
                    isProgressing = false; 
                } else {
                    width++;
                    elem.innerHTML = width; 
                    elem.style.width = (width / maxProgress) * 100 + '%'; 
                }
            }, stepTime); 
        }

        function updateTimer() {
            if (isProgressing) {
                var currentTime = new Date();
                var elapsedMilliseconds = currentTime - startTime;
                var elapsedSeconds = Math.floor(elapsedMilliseconds / 1000);
                var milliseconds = elapsedMilliseconds % 1000;
                var minutes = Math.floor(elapsedSeconds / 60);
                var seconds = elapsedSeconds % 60;
                document.getElementById("timer").innerHTML = `Elapsed Time: ${minutes}m ${seconds}s ${Math.floor(milliseconds / 10)}ms`;
            }
        }
    </script>
</asp:Content>