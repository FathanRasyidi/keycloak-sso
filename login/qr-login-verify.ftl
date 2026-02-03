<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("doQrCodeVerify")}
    <#elseif section = "header">
        ${msg("doQrCodeVerify")}
    <#elseif section = "form">
        <div class="mb-8">
            <h1 class="text-3xl sm:text-4xl font-bold mb-3 text-gray-900 dark:text-white">${msg("doQrCodeVerify")}</h1>
            <p class="text-gray-500 dark:text-gray-400">${msg("doQrCodeWarning")}</p>
        </div>

        <div class="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-4 mb-6">
            <div class="flex items-start gap-3">
                <span class="material-icons-round text-blue-600 dark:text-blue-400 text-2xl flex-shrink-0">info</span>
                <div class="flex-1">
                    <p class="text-sm text-blue-800 dark:text-blue-200 mb-3">
                        Anda mengotorisasi sesi login pada:
                    </p>
                    <div class="space-y-2 text-sm text-blue-700 dark:text-blue-300">
                        <div class="flex items-center gap-2">
                            <span class="material-icons-round text-base">devices</span>
                            <span><b>Device:</b> ${ua_device}</span>
                        </div>
                        <div class="flex items-center gap-2">
                            <span class="material-icons-round text-base">computer</span>
                            <span><b>OS:</b> ${ua_os}</span>
                        </div>
                        <div class="flex items-center gap-2">
                            <span class="material-icons-round text-base">web</span>
                            <span><b>Browser:</b> ${ua_agent}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <p class="text-sm text-gray-500 dark:text-gray-400 text-center mb-6">
            <b>Session:</b> ${tabId}
        </p>

        <div class="space-y-3">
            <a type="button" href="${approveURL}" 
                class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500 transition-colors">
                <span class="material-icons-round mr-2">check_circle</span>
                ${msg("doAccept")}
            </a>

            <a type="button" href="${rejectURL}" 
                class="w-full flex justify-center items-center py-3 px-4 border border-gray-300 dark:border-gray-600 rounded-lg shadow-sm text-sm font-medium text-gray-700 dark:text-gray-200 bg-white dark:bg-surface-dark hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transition-colors">
                <span class="material-icons-round mr-2">cancel</span>
                ${msg("doDecline")}
            </a>
        </div>
    </#if>
</@layout.registrationLayout>