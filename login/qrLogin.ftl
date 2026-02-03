<#macro qrLogin>
    <div id="com-hadleyso-qr-auth">
        <div class="mt-4">
            <button type="button" 
                onclick="showQRModal()" 
                class="w-full flex justify-center items-center py-3 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm bg-white dark:bg-surface-dark text-sm font-medium text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                <span class="material-icons-round mr-2">qr_code_scanner</span>
                ${msg("doQrCodeLogin")}
            </button>
        </div>

        <div id="qr-auth-data" style="display: none;"
            data-qr-image="${QRauthImage}" 
            data-qr-exec-id="${QRauthExecId}" 
            data-tab-id="${tabId!'N/A'}">
        </div>

        <form id="com-hadleyso-qrcode-${QRauthExecId}" action="${url.loginAction}" method="post" style="display: none;">
            <input type="hidden" name="authenticationExecution" value="${QRauthExecId}">
        </form>
    </div>

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
</#macro>