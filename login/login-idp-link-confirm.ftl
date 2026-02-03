<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    
    <#-- HEADER -->
    <#if section = "header">
        Konfirmasi Tautan Akun - SSO PEMDA DIY
        
    <#-- FORM (Kiri) -->
    <#elseif section = "form">
        <div class="mb-8">
            <div class="w-16 h-16 bg-primary/10 dark:bg-accent/10 rounded-full flex items-center justify-center mb-6">
                <span class="material-icons-round text-3xl text-primary dark:text-accent">link</span>
            </div>
            
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white">Tautkan Akun?</h1>
            <p class="text-gray-500 dark:text-gray-400">
                Kami mendeteksi akun dengan email yang sama sudah terdaftar.
            </p>
        </div>

        <div class="bg-surface-light dark:bg-surface-dark p-4 rounded-xl border border-gray-200 dark:border-gray-700 mb-6">
            <div class="flex flex-col gap-1">
                <span class="text-xs font-semibold text-gray-500 uppercase tracking-wider">Email Terdeteksi</span>
                <span class="text-base font-medium text-primary dark:text-accent font-mono">
                    <#if brokerContext?? && brokerContext.email??>
                        ${brokerContext.email}
                    <#elseif user?? && user.email??>
                        ${user.email}
                    <#else>
                        (Email tidak terdeteksi)
                    </#if>
                </span>
            </div>
            <div class="mt-3 text-sm text-gray-600 dark:text-gray-300 border-t border-gray-200 dark:border-gray-600 pt-3">
                Apakah Anda ingin menghubungkan akun <strong>${idpAlias! "Sosial Media"}</strong> ini dengan akun lama Anda?
            </div>
        </div>

        <form action="${url.loginAction}" class="space-y-3" method="post">
            
            <button type="submit" name="submitAction" value="linkAccount" 
                class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors">
                <span class="material-icons-round mr-2 text-xl">check_circle</span>
                Ya, Tautkan Akun
            </button>
            
            <a href="${url.loginRestartFlowUrl!'/realms/PemdaSSO/account'}" 
                class="w-full flex justify-center items-center py-3 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm text-sm font-medium text-gray-700 dark:text-gray-200 bg-white dark:bg-surface-dark hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                Batal
            </a>
            
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
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Integrasi</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Satu Akun <br />
                        <span class="text-primary/70 italic font-light">Banyak Akses</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Hubungkan akun Google atau sosial media Anda untuk kemudahan login tanpa perlu menghafal banyak password.
                    </p>
                </div>
            </div>
             <#-- Slide 2 -->
            <div class="insight-slide" data-slide="1">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Keamanan</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Verifikasi <br />
                        <span class="text-primary/70 italic font-light">Identitas Digital</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Proses penautan akun memastikan bahwa Anda adalah pemilik sah dari kedua akun tersebut.
                    </p>
                </div>
            </div>
            <#-- Slide 3 -->
            <div class="insight-slide" data-slide="2">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Fleksibel</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Akses Dimana Saja <br />
                        <span class="text-primary/70 italic font-light">Kapan Saja</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Nikmati kemudahan akses layanan publik digital PEMDA DIY melalui berbagai perangkat dengan aman.
                    </p>
                </div>
            </div>
        </div>
        
        <#-- Slider Navigation -->
        <div class="flex items-center gap-6 mt-auto">
            <div class="flex items-center gap-3" id="sliderDots">
                <div class="slider-dot-wrapper active cursor-pointer" data-slide="0"><div class="slider-dot-bg"></div><div class="slider-dot-progress"></div></div>
                <div class="slider-dot-wrapper cursor-pointer" data-slide="1"><div class="slider-dot-bg"></div><div class="slider-dot-progress"></div></div>
                <div class="slider-dot-wrapper cursor-pointer" data-slide="2"><div class="slider-dot-bg"></div><div class="slider-dot-progress"></div></div>
            </div>
            <div class="flex gap-2">
                <button id="sliderPrev" class="w-8 h-8 flex items-center justify-center rounded-full border border-gray-300 text-gray-400 hover:border-primary hover:text-primary hover:bg-white transition-all duration-300">
                    <span class="material-icons-round text-lg">arrow_back</span>
                </button>
                <button id="sliderNext" class="w-8 h-8 flex items-center justify-center rounded-full bg-primary text-white shadow-lg shadow-primary/20 hover:bg-primary/90 hover:scale-105 transition-all duration-300">
                    <span class="material-icons-round text-lg">arrow_forward</span>
                </button>
            </div>
        </div>
    </#if>
</@layout.registrationLayout>