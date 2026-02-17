<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=false; section>
    <#if section = "form">
        <div class="mb-8">
            <div class="w-16 h-16 bg-blue-100 dark:bg-blue-900/30 rounded-full flex items-center justify-center mb-6">
                <span class="material-icons-round text-3xl text-blue-600 dark:text-blue-400">email</span>
            </div>
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white">Verifikasi Email</h1>
            <p class="text-gray-500 dark:text-gray-400">Kami telah mengirimkan email verifikasi ke alamat email Anda</p>
        </div>

        <#if message?has_content>
            <#if message.type == 'warning'>
                <div class="p-4 rounded-lg bg-yellow-50 border border-yellow-200 text-yellow-700 text-sm flex items-start gap-3 mb-6">
                    <span class="material-icons-round text-yellow-500 text-xl flex-shrink-0">warning</span>
                    <div>
                        <p class="text-yellow-600">${kcSanitize(message.summary)?no_esc}</p>
                    </div>
                </div>
            <#elseif message.type == 'error'>
                <div class="p-4 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm flex items-start gap-3 mb-6">
                    <span class="material-icons-round text-red-500 text-xl flex-shrink-0">error</span>
                    <div>
                        <p class="text-red-600">${kcSanitize(message.summary)?no_esc}</p>
                    </div>
                </div>
            <#else>
                <div class="p-4 rounded-lg bg-blue-50 border border-blue-200 text-blue-700 text-sm flex items-start gap-3 mb-6">
                    <span class="material-icons-round text-blue-500 text-xl flex-shrink-0">info</span>
                    <div>
                        <p class="text-blue-600">${kcSanitize(message.summary)?no_esc}</p>
                    </div>
                </div>
            </#if>
        </#if>

        <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-6 border border-gray-200 dark:border-gray-700 mb-6">
            <div class="flex items-center gap-4 mb-4">
                <div class="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center">
                    <span class="material-icons-round text-2xl text-primary">mark_email_read</span>
                </div>
                <div>
                    <p class="text-sm font-semibold text-gray-900 dark:text-white">Cek Inbox Email Anda</p>
                    <p class="text-xs text-gray-500 dark:text-gray-400">Termasuk folder spam/junk</p>
                </div>
            </div>
            <ol class="text-sm text-gray-600 dark:text-gray-300 space-y-2 ml-4">
                <li class="flex items-start gap-2">
                    <span class="text-primary font-semibold">1.</span>
                    <span>Buka email dari SSO PEMDA DIY</span>
                </li>
                <li class="flex items-start gap-2">
                    <span class="text-primary font-semibold">2.</span>
                    <span>Klik link verifikasi di dalam email</span>
                </li>
                <li class="flex items-start gap-2">
                    <span class="text-primary font-semibold">3.</span>
                    <span>Akun Anda akan aktif secara otomatis</span>
                </li>
            </ol>
        </div>

        <p class="text-center text-sm text-gray-500 dark:text-gray-400 mb-4">
            Belum menerima email?
        </p>

        <form action="${url.loginAction}" method="POST">
            <button class="w-full flex justify-center items-center py-3 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm text-sm font-medium text-gray-700 dark:text-gray-200 bg-white dark:bg-surface-dark hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors"
                type="submit">
                <span class="material-icons-round mr-2 text-xl">refresh</span>
                Kirim Ulang Email Verifikasi
            </button>
        </form>

        <a href="${url.loginRestartFlowUrl!url.loginUrl}" class="mt-6 inline-flex items-center text-sm text-gray-500 dark:text-gray-400 hover:text-primary dark:hover:text-accent">
            <span class="material-icons-round mr-1 text-lg">arrow_back</span>
            Kembali ke halaman login
        </a>

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
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Verifikasi</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Verifikasi Email <br />
                        <span class="text-primary/70 italic font-light">Untuk Keamanan</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Verifikasi email memastikan bahwa Anda adalah pemilik sah akun dan melindungi akun dari penyalahgunaan.
                    </p>
                </div>
            </div>
        </div>

    <#elseif section = "script">
    </#if>
</@layout.registrationLayout>
