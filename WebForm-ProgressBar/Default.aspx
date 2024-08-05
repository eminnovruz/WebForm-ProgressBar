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
                    <div id="timer">0s</div>
                </div>
            </div>
        </div>
    </div>

    <style>
        body {
            background-color: #f0f8ff;
            color: #000000;
            font-family: Arial, sans-serif;
            margin: 0;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.3);
        }

        .modal-content {
            background-color: #ffffff; 
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #ccc;
            width: 80%;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 15px;
            border-bottom: 1px solid #ddd;
        }

        .close {
            color: #888;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

        .progress-container {
            background-color: #e0f7fa; 
            border-radius: 15px;
            overflow: hidden;
            box-shadow: #034ea3;
            margin: 20px 0;
            height: 20px;
        }

        #progressBar {
            width: 0%;
            height: 100%;
            background: linear-gradient(to right, #b3e5fc, #034ea3); 
            text-align: center;
            line-height: 20px;
            color: #ffffff;
            transition: width 0.3s ease;
            border-radius: 15px;
        }

        .progress-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 10px;
        }

        #currentStep, #timer {
            font-size: 18px;
            font-weight: bold;
            color: #000000; 
        }
    </style>

    <script type="text/javascript">
        var maxProgress = 100;
        var stepTime = 100;
        var progressStartTime;
        var isProgressing = false;
        var timerInterval;

        function startProgress() {
            if (isProgressing) return;

            isProgressing = true;
            var elem = document.getElementById("progressBar");
            var stepElem = document.getElementById("currentStep");
            var timerElem = document.getElementById("timer");
            var width = 0;

            progressStartTime = new Date();
            elem.innerHTML = width;
            elem.style.width = (width / maxProgress) * 100 + '%';

            var progressInterval = setInterval(function () {
                var elapsedTime = new Date() - progressStartTime;
                width = Math.min(maxProgress, Math.floor(elapsedTime / stepTime));

                if (width >= maxProgress) {
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
            document.getElementById("timer").innerHTML = `${minutes}d ${seconds}s ${milliseconds}ms`;
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
