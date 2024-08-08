<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebForm_ProgressBar._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="progressModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <span id="closeModal" class="close">&times;</span>
            </div>
            <div class="modal-body">
                <div class="progress-container">
                    <div id="progressBar">0</div>
                </div>
                <div class="progress-info">
                    <div id="currentStep">0</div>
                    <div id="timer">0s</div>
                </div>
                <div class="time-info">
                    <div id="startTime">Started</div>
                    <div id="endTime">Ended</div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
            overflow: auto;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            padding: 10px 20px;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .modal-header h2 {
            margin: 0;
        }

        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .progress-container {
            background-color: #e0f7fa;
            border-radius: 10px;
            overflow: hidden;
            height: 25px;
            margin-bottom: 10px;
        }

        #progressBar {
            width: 0;
            height: 100%;
            background: linear-gradient(to right, #b3e5fc, #0288d1);
            text-align: center;
            line-height: 25px;
            color: #fff;
            transition: width 0.4s ease;
        }

        .progress-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 18px;
            font-weight: bold;
        }

        .time-info {
            margin-top: 20px;
        }

        .time-info div {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }
    </style>

    <script type="text/javascript">
        var maxProgress = 100;
        var stepTime = 100;
        var progressStartTime;
        var progressEndTime;
        var isProgressing = false;
        var timerInterval;

        function startProgress() {
            if (isProgressing) return;

            isProgressing = true;
            var elem = document.getElementById("progressBar");
            var stepElem = document.getElementById("currentStep");
            var timerElem = document.getElementById("timer");
            var startTimeElem = document.getElementById("startTime");
            var endTimeElem = document.getElementById("endTime");
            var width = 0;

            progressStartTime = new Date();
            startTimeElem.innerHTML = `Start Time: ${formatTime(progressStartTime)}`;

            elem.innerHTML = width;
            elem.style.width = (width / maxProgress) * 100 + '%';

            var progressInterval = setInterval(function () {
                var elapsedTime = new Date() - progressStartTime;
                width = Math.min(maxProgress, Math.floor(elapsedTime / stepTime));

                if (width >= maxProgress) {
                    progressEndTime = new Date();
                    endTimeElem.innerHTML = `End Time: ${formatTime(progressEndTime)}`;
                    clearInterval(progressInterval);
                    clearInterval(timerInterval);
                    isProgressing = false;
                }

                elem.innerHTML = width;
                elem.style.width = (width / maxProgress) * 100 + '%';
            }, stepTime);

            timerInterval = setInterval(updateTimer, 100);
        }

        function updateTimer() {
            var currentTime = new Date();
            var elapsedMilliseconds = currentTime - progressStartTime;
            var elapsedSeconds = Math.floor(elapsedMilliseconds / 1000);
            var milliseconds = elapsedMilliseconds % 1000;
            var minutes = Math.floor(elapsedSeconds / 60);
            var seconds = elapsedSeconds % 60;
            document.getElementById("timer").innerHTML = `${minutes}m ${seconds}s ${milliseconds}ms`;
        }

        function formatTime(date) {
            var hours = String(date.getHours()).padStart(2, '0');
            var minutes = String(date.getMinutes()).padStart(2, '0');
            var seconds = String(date.getSeconds()).padStart(2, '0');
            return `${hours}:${minutes}:${seconds}`;
        }

        window.onload = function () {
            openModal();
            startProgress();
        };

        function openModal() {
            document.getElementById("progressModal").style.display = "block";
        }

        function closeModal() {
            document.getElementById("progressModal").style.display = "none";
        }

        document.getElementById("closeModal").onclick = function () {
            closeModal();
        }

        window.onclick = function (event) {
            var modal = document.getElementById("progressModal");
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</asp:Content>
