<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("consentDenied")}
    <#elseif section = "header">
        ${msg("consentDenied")}
    <#elseif section = "form">
        <div class="flex flex-col items-center justify-center py-12">
            <div class="bg-red-100 dark:bg-red-900/30 rounded-full p-6 mb-6">
                <span class="material-icons-round text-red-600 dark:text-red-400" style="font-size: 64px;">cancel</span>
            </div>
            
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white text-center">
                ${msg("consentDenied")}
            </h1>
            
            <p class="text-gray-500 dark:text-gray-400 text-center max-w-md mb-6">
                Login dengan QR Code telah dibatalkan.
            </p>

            <a href="${url.loginUrl}" 
                class="inline-flex items-center py-2.5 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors">
                <span class="material-icons-round mr-2">arrow_back</span>
                Kembali ke Login
            </a>
        </div>
    </#if>
</@layout.registrationLayout>