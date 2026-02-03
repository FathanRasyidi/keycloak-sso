<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "form">
        <div class="mb-8">
            <div class="w-16 h-16 bg-primary/10 dark:bg-accent/10 rounded-full flex items-center justify-center mb-6">
                <span class="material-icons-round text-3xl text-primary dark:text-accent">how_to_reg</span>
            </div>
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white">Konfirmasi Email</h1>
            <p class="text-gray-500 dark:text-gray-400">Silakan konfirmasi alamat email Anda</p>
        </div>

        <#if message?has_content && (message.type == 'error' || message.type == 'warning')>
            <div class="p-4 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm flex items-start gap-3 mb-6">
                <span class="material-icons-round text-red-500 text-xl flex-shrink-0">error</span>
                <div>
                    <p class="font-medium">Kesalahan</p>
                    <p class="text-red-600">${kcSanitize(message.summary)?no_esc}</p>
                </div>
            </div>
        </#if>

        <form action="${url.loginAction}" class="space-y-5" method="POST" id="kc-email-confirm-form">
            <div class="space-y-1">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="email">Email</label>
                <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 text-sm"
                    id="email" 
                    name="email"
                    placeholder="email@jogjaprov.go.id" 
                    type="email"
                    autofocus
                    value="${(email!'')}"
                    autocomplete="email" />
            </div>

            <button class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors"
                type="submit">
                <span class="material-icons-round mr-2 text-xl">check_circle</span>
                Konfirmasi
            </button>
        </form>

        <a href="${url.loginUrl}" class="mt-6 inline-flex items-center text-sm text-gray-500 dark:text-gray-400 hover:text-primary dark:hover:text-accent">
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
                        Konfirmasi Email <br />
                        <span class="text-primary/70 italic font-light">Untuk Keamanan</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Konfirmasi email memastikan bahwa Anda adalah pemilik sah akun dan melindungi akun dari penyalahgunaan.
                    </p>
                </div>
            </div>
        </div>

    <#elseif section = "script">
    </#if>
</@layout.registrationLayout>
