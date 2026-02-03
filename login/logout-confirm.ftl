<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "form">
        <div class="mb-8">
            <div class="w-16 h-16 bg-yellow-100 dark:bg-yellow-900/30 rounded-full flex items-center justify-center mb-6">
                <span class="material-icons-round text-3xl text-yellow-600 dark:text-yellow-400">logout</span>
            </div>
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white">Konfirmasi Logout</h1>
            <p class="text-gray-500 dark:text-gray-400">Apakah Anda yakin ingin keluar dari sistem SSO?</p>
        </div>

        <#if message?has_content>
            <#if message.type == 'warning'>
                <div class="p-4 rounded-lg bg-yellow-50 border border-yellow-200 text-yellow-700 text-sm flex items-start gap-3 mb-6">
                    <span class="material-icons-round text-yellow-500 text-xl flex-shrink-0">warning</span>
                    <div>
                        <p class="text-yellow-600">${kcSanitize(message.summary)?no_esc}</p>
                    </div>
                </div>
            </#if>
        </#if>

        <div class="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-4 mb-6">
            <div class="flex items-start gap-3">
                <span class="material-icons-round text-blue-500 text-xl flex-shrink-0">info</span>
                <div>
                    <p class="text-sm font-medium text-blue-800 dark:text-blue-200">Informasi</p>
                    <p class="text-xs text-blue-600 dark:text-blue-300 mt-1">Dengan logout, Anda akan keluar dari semua aplikasi yang terhubung dengan SSO PEMDA DIY.</p>
                </div>
            </div>
        </div>

        <form class="space-y-4" action="${url.logoutConfirmAction}" method="POST">
            <input type="hidden" name="session_code" value="${logoutConfirm.code}">
            <div class="flex gap-4">
                <#if logoutConfirm.skipLink??>
                <#else>
                    <#if client?? && client.baseUrl?has_content>
                        <a href="${client.baseUrl}" class="flex-1 flex justify-center items-center py-3 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm text-sm font-medium text-gray-700 dark:text-gray-200 bg-white dark:bg-surface-dark hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                            Batal
                        </a>
                    </#if>
                </#if>
                <button class="flex-1 flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors"
                    type="submit" name="confirmLogout" id="kc-logout" value="true">
                    <span class="material-icons-round mr-2 text-xl">logout</span>
                    Ya, Logout
                </button>
            </div>
        </form>

    <#elseif section = "footer">
        <p class="text-sm text-gray-500 dark:text-gray-400">
            ${msg("needHelp")} <a class="font-medium text-primary dark:text-accent hover:underline" href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank" rel="noopener noreferrer">${msg("contactSupport")}</a>
        </p>
        
        <div class="mt-4 pt-4 border-t border-gray-200 dark:border-gray-700">
            <div
                class="flex flex-wrap items-center justify-center lg:justify-start gap-x-4 gap-y-2 text-xs text-gray-500 dark:text-gray-400">
                <a href="https://drive.google.com/file/d/1nvLDfcjULstrpKbt-8o3nSY23FgCMxl4/view" target="_blank"
                    rel="noopener noreferrer"
                    class="inline-flex items-center gap-1 hover:text-primary dark:hover:text-accent transition-colors">
                    <span class="material-icons-round text-sm">policy</span>
                    <span>Kebijakan Privasi</span>
                </a>
                <span class="text-gray-300 dark:text-gray-600">•</span>
                <a href="https://diskominfo.notion.site/28e22b0cdb8080e6a777e835aee5cff7?pvs=105"
                    target="_blank" rel="noopener noreferrer"
                    class="inline-flex items-center gap-1 hover:text-primary dark:hover:text-accent transition-colors">
                    <span class="material-icons-round text-sm">feedback</span>
                    <span>Kritik & Saran</span>
                </a>
                <span class="text-gray-300 dark:text-gray-600">•</span>
                <a href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank"
                    rel="noopener noreferrer"
                    class="inline-flex items-center gap-1 hover:text-primary dark:hover:text-accent transition-colors">
                    <span class="material-icons-round text-sm">support_agent</span>
                    <span>Kontak Kami</span>
                </a>
            </div>
        </div>

    <#elseif section = "info">
        <div class="insight-slider relative overflow-hidden">
            <div class="insight-slide active" data-slide="0">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">SSO</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Single Sign-On <br />
                        <span class="text-primary/70 italic font-light">PEMDA DIY</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Terima kasih telah menggunakan layanan SSO PEMDA DIY. Sampai jumpa kembali!
                    </p>
                </div>
            </div>
        </div>

    <#elseif section = "script">
    </#if>
</@layout.registrationLayout>
