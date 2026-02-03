<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "form">
        <div class="mb-8">
            <div class="w-16 h-16 bg-yellow-100 dark:bg-yellow-900/30 rounded-full flex items-center justify-center mb-6">
                <span class="material-icons-round text-3xl text-yellow-600 dark:text-yellow-400">schedule</span>
            </div>
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white">Sesi Kedaluwarsa</h1>
            <p class="text-gray-500 dark:text-gray-400">Sesi login Anda telah berakhir. Silakan mulai ulang proses login.</p>
        </div>

        <div class="bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 rounded-lg p-4 mb-6">
            <div class="flex items-start gap-3">
                <span class="material-icons-round text-yellow-500 text-xl flex-shrink-0">info</span>
                <div>
                    <p class="text-sm font-medium text-yellow-800 dark:text-yellow-200">Mengapa ini terjadi?</p>
                    <p class="text-xs text-yellow-600 dark:text-yellow-300 mt-1">Sesi kedaluwarsa untuk alasan keamanan setelah periode tidak aktif atau halaman terlalu lama terbuka.</p>
                </div>
            </div>
        </div>

        <div class="space-y-3">
            <#if client?? && client.baseUrl?has_content>
                <a href="${client.baseUrl}" class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors">
                    <span class="material-icons-round mr-2 text-xl">refresh</span>
                    Mulai Ulang
                </a>
            </#if>
            <a href="${url.loginRestartFlowUrl}" class="w-full flex justify-center items-center py-3 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm text-sm font-medium text-gray-700 dark:text-gray-200 bg-white dark:bg-surface-dark hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                <span class="material-icons-round mr-2 text-xl">login</span>
                Login Ulang
            </a>
        </div>

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
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Keamanan</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Sesi Expired <br />
                        <span class="text-primary/70 italic font-light">Untuk Keamanan</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Sistem secara otomatis mengakhiri sesi yang tidak aktif untuk melindungi keamanan akun Anda.
                    </p>
                </div>
            </div>
        </div>

    <#elseif section = "script">
    </#if>
</@layout.registrationLayout>
