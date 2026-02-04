<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=false; section>

    <#-- 
        SILENT REDIRECTOR 
        This page serves solely to bounce the user back to the QR Code flow (restart_flow)
        when a standard login error occurs, preserving the error message via URL parameters.
    -->

    <#if section = "form">
        <#-- Calculate redirect target -->
        <#assign targetUrl = url.loginRestartFlowUrl!url.loginUrl>
        
        <script>
            // Prepare error data
            <#if message?has_content>
                const errorData = {
                    type: '${message.type!'unknown'}',
                    summary: '${message.summary!''?js_string}'
                };
                // Save to sessionStorage to survive the redirect
                sessionStorage.setItem('auth_error', JSON.stringify(errorData));
            </#if>

            // Immediate redirect
            window.location.href = "${targetUrl?no_esc}";
        </script>
        
        <noscript>
            <div class="flex flex-col items-center justify-center p-8">
                <p>Redirecting...</p>
                <a href="${targetUrl?no_esc}" class="text-blue-600 underline">Click here if not redirected</a>
            </div>
        </noscript>
    </#if>
</@layout.registrationLayout>
