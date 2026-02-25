<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=false; section>

    <#-- 
        SILENT REDIRECTOR 
        Halaman ini berfungsi untuk mengembalikan user ke flow QR Code (restart_flow)
        ketika terjadi kesalahan login standar, dengan menyimpan pesan kesalahan melalui parameter URL.
        Ini terjadi karena login.ftl tidak digunakan dalam default flow jika menggunakan QR Code Extension.
    -->

    <#if section = "form">
        <#-- Untuk redirect target -->
        <#assign targetUrl = url.loginRestartFlowUrl!url.loginUrl>
        
        <script>
            // Untuk error data
            <#if message?has_content>
                const errorData = {
                    type: '${message.type!'unknown'}',
                    summary: '${message.summary!''?js_string}'
                };
                // Simpan ke sessionStorage untuk redirect
                sessionStorage.setItem('auth_error', JSON.stringify(errorData));
            </#if>

            // Redirect
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
