<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    
    <#-- HEADER -->
    <#if section = "header">
        <#if credentialLabel??>
            Hapus ${credentialLabel}
        <#else>
            Hapus Kredensial
        </#if>
        
    <#-- FORM (Kiri) -->
    <#elseif section = "form">
        <div class="mb-8">
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white" id="kc-delete-text">
                Hapus Kredensial
            </h1>
            <p class="text-gray-500 dark:text-gray-400">
                <#if credentialLabel??>
                    Apakah Anda yakin ingin menghapus data kredensial <strong>${credentialLabel}</strong> ini?
                <#else>
                    Apakah Anda yakin ingin menghapus data kredensial ini?
                </#if>
            </p>
        </div>

        <form action="${url.loginAction}" class="flex gap-3" method="post">
            
            <button type="submit" name="accept" id="kc-accept" value="${msg('doConfirmDelete')!''}" 
                class="flex-1 py-2.5 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-red-600 hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500 transition-colors">
                Konfirmasi Hapus
            </button>
            
            <button type="submit" name="cancel-aia" id="kc-decline" value="${msg('doDecline')!''}" 
                class="flex-1 py-2.5 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm text-sm font-medium text-gray-700 dark:text-gray-200 bg-white dark:bg-surface-dark hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                Batal
            </button>
            
        </form>

    <#-- FOOTER -->
    <#elseif section = "footer">
        <p class="text-sm text-gray-500 dark:text-gray-400">
             Butuh bantuan? <a class="font-medium text-primary dark:text-accent hover:underline" href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank" rel="noopener noreferrer">Hubungi Admin</a>
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

    <#-- SLIDER (Kanan) -->
    <#elseif section = "info">
        <div class="insight-slider relative overflow-hidden">
            <#-- Slide 1 -->
            <div class="insight-slide active" data-slide="0">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-red-100 dark:bg-red-900/30 text-red-600 dark:text-red-400 text-[10px] font-bold tracking-widest uppercase mb-4">Pengaturan Akun</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Penghapusan<br />
                        <span class="text-red-600 italic font-light">Tindakan Permanen</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-red-500 pl-4">
                        Menghapus kredensial ini akan membuatnya tidak lagi dapat digunakan untuk masuk ke akun Anda. Pastikan Anda memiliki metode login alternatif yang masih aktif.
                    </p>
                </div>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>
