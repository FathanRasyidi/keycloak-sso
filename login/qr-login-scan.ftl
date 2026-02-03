<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("doQrCodeLogin")}
    <#elseif section = "header">
        ${msg("doQrCodeLogin")}
    <#elseif section = "form">
        <div class="mb-8">
            <h1 class="text-3xl sm:text-4xl font-bold mb-3 text-gray-900 dark:text-white">${msg("doQrCodeLogin")}</h1>
            <p class="text-gray-500 dark:text-gray-400">Scan QR code menggunakan aplikasi mobile PEMDA DIY</p>
        </div>

        <div id="com-hadleyso-qr-auth-js-target" 
            class="flex flex-col items-center my-6 cursor-pointer"
            onclick="document.forms['com-hadleyso-qrcode-${QRauthExecId}'].submit();">
            <span style="display: none;">${QRauthToken}</span>
            <div class="relative bg-white dark:bg-gray-800 p-6 rounded-xl shadow-lg qr-float">
                <img id="com-hadleyso-qr-auth-qr-code" 
                    src="data:image/png;base64,${QRauthImage}" 
                    alt="QR Code" 
                    class="w-64 h-64 hover:opacity-80 transition-opacity">
            </div>
        </div>

        <p class="text-sm text-gray-500 dark:text-gray-400 text-center mb-6">
            <b>Session:</b> ${tabId}
        </p>

        <form id="com-hadleyso-qrcode-${QRauthExecId}" action="${url.loginAction}" method="post">
            <input type="hidden" name="authenticationExecution" value="${QRauthExecId}">
            <button type="submit" 
                class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors">
                <span class="material-icons-round mr-2">refresh</span>
                ${msg("doLogIn")}
            </button>
        </form>

        <#if refreshRate != 0>
            <script>
                setTimeout(function() {
                    document.getElementById("com-hadleyso-qrcode-${QRauthExecId}").submit();
                }, ${refreshRate}000);
            </script>
        </#if>

        <script type="text/javascript">
            var getUrlParameter = function getUrlParameter(sParam) {
                var sPageURL = window.location.search.substring(1),
                    sURLVariables = sPageURL.split('&'),
                    sParameterName,
                    i;

                for (i = 0; i < sURLVariables.length; i++) {
                    sParameterName = sURLVariables[i].split('=');

                    if (sParameterName[0] === sParam) {
                        return true;
                    }
                }
                return false;
            };

            if (getUrlParameter('qr_code_originated') == true) {
                document.getElementById("com-hadleyso-qr-auth").style.display = "none";
            }
        </script>

        <style>
            @keyframes float {
                0%, 100% { transform: translateY(0px); }
                50% { transform: translateY(-10px); }
            }
            .qr-float {
                animation: float 3s ease-in-out infinite;
            }
        </style>
    </#if>
</@layout.registrationLayout>