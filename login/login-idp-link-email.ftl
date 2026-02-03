<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "form">
        <div class="mb-8">
            <div class="w-16 h-16 bg-primary/10 dark:bg-accent/10 rounded-full flex items-center justify-center mb-6">
                <span class="material-icons-round text-3xl text-primary dark:text-accent">mail</span>
            </div>
            <h1 class="text-3xl sm:text-4xl font-bold mb-3 text-gray-900 dark:text-white">Cek Email Anda</h1>
            <p class="text-gray-500 dark:text-gray-400">Email verifikasi telah dikirim</p>
        </div>

        <#-- Info box with instructions -->
        <div class="bg-primary/5 dark:bg-primary/10 border border-primary/20 dark:border-primary/30 rounded-lg p-5 mb-6">
            <div class="flex items-start gap-3">
                <span class="material-icons-round text-primary dark:text-accent text-xl flex-shrink-0 mt-0.5">info</span>
                <div class="flex-1">
                    <p class="text-sm text-gray-900 dark:text-gray-200 mb-3">
                        <#assign providerName = "">
                        <#if idpAlias??>
                            <#if idpAlias?lower_case?contains("google")>
                                <#assign providerName = "Google">
                            <#elseif idpAlias?lower_case?contains("github")>
                                <#assign providerName = "GitHub">
                            <#else>
                                <#assign providerName = idpAlias>
                            </#if>
                        </#if>
                        
                        An email with instructions to link ${providerName} account 
                        <strong class="font-semibold">${brokerContext.username}</strong> with your PemdaSSO account has been sent to you.
                    </p>
                    
                    <div class="space-y-2 text-xs text-gray-700 dark:text-gray-300">                        
                        <p>If you already verified the email in a different browser <a href="#" class="font-medium text-primary hover:underline" onclick="window.location.reload(); return false;">Click here to continue</a>.</p>
                    </div>
                </div>
            </div>
        </div>

        <#-- Action buttons -->
        <a href="${url.loginAction}" class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors">
            <span class="material-icons-round mr-2 text-xl">refresh</span>
            Kirim Ulang Email
        </a>

        <a href="${url.loginUrl}" class="mt-8 inline-flex items-center text-sm text-gray-500 dark:text-gray-400 hover:text-primary dark:hover:text-accent">
            <span class="material-icons-round mr-1 text-lg">arrow_back</span>
            Kembali ke Beranda
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
        <#-- Slider Container -->
        <div class="insight-slider relative overflow-hidden">
            <#-- Slide 1: Link Account -->
            <div class="insight-slide active" data-slide="0">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Verifikasi</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Verifikasi Email <br />
                        <span class="text-primary/70 italic font-light">Link Akun Sosial</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Kami telah mengirimkan email verifikasi untuk mengonfirmasi bahwa Anda adalah pemilik sah dari akun tersebut.
                    </p>
                </div>
            </div>
            <#-- Slide 2: Security -->
            <div class="insight-slide" data-slide="1">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Keamanan</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Perlindungan <br />
                        <span class="text-primary/70 italic font-light">Identitas Digital Anda</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Proses verifikasi email memastikan bahwa hanya Anda yang dapat menghubungkan akun sosial media dengan akun SSO PEMDA DIY.
                    </p>
                </div>
            </div>
            <#-- Slide 3: Easy Access -->
            <div class="insight-slide" data-slide="2">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Kemudahan</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Login Sekali Klik <br />
                        <span class="text-primary/70 italic font-light">Tanpa Password</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Setelah akun terhubung, Anda dapat login dengan mudah menggunakan akun Google atau GitHub tanpa perlu mengingat password.
                    </p>
                </div>
            </div>
        </div>
        <#-- Slider Navigation -->
        <div class="flex items-center gap-6 mt-auto">
            <div class="flex items-center gap-3" id="sliderDots">
                <div class="slider-dot-wrapper active cursor-pointer" data-slide="0">
                    <div class="slider-dot-bg"></div>
                    <div class="slider-dot-progress"></div>
                </div>
                <div class="slider-dot-wrapper cursor-pointer" data-slide="1">
                    <div class="slider-dot-bg"></div>
                    <div class="slider-dot-progress"></div>
                </div>
                <div class="slider-dot-wrapper cursor-pointer" data-slide="2">
                    <div class="slider-dot-bg"></div>
                    <div class="slider-dot-progress"></div>
                </div>
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

    <#elseif section = "script">
    </#if>
</@layout.registrationLayout>
