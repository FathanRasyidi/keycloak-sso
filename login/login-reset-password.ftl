<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "form">
        <div class="mb-8">
            <div class="w-16 h-16 bg-primary/10 dark:bg-accent/10 rounded-full flex items-center justify-center mb-6">
                <span class="material-icons-round text-3xl text-primary dark:text-accent">lock_reset</span>
            </div>
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white">${msg("resetPasswordTitle")}</h1>
            <p class="text-gray-500 dark:text-gray-400">${msg("resetPasswordSubtitle")}</p>
        </div>

        <form action="${url.loginAction}" class="space-y-5" method="POST" id="kc-reset-password-form">
            <#-- Alert Error -->
            <#if messagesPerField.existsError('username')>
                <div class="p-4 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm flex items-start gap-3">
                    <span class="material-icons-round text-red-500 text-xl flex-shrink-0">error</span>
                    <div>
                        <p class="font-medium">Kesalahan</p>
                        <p class="text-red-600">${kcSanitize(messagesPerField.getFirstError('username'))?no_esc}</p>
                    </div>
                </div>
            <#elseif message?has_content && (message.type == 'error' || message.type == 'warning')>
                <div class="p-4 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm flex items-start gap-3">
                    <span class="material-icons-round text-red-500 text-xl flex-shrink-0">error</span>
                    <div>
                        <p class="font-medium">Kesalahan</p>
                        <p class="text-red-600">${kcSanitize(message.summary)?no_esc}</p>
                    </div>
                </div>
            <#elseif message?has_content && message.type == 'success'>
                <div class="p-4 rounded-lg bg-green-50 border border-green-200 text-green-700 text-sm flex items-start gap-3">
                    <span class="material-icons-round text-green-500 text-xl flex-shrink-0">check_circle</span>
                    <div>
                        <p class="font-medium">Berhasil</p>
                        <p class="text-green-600">${kcSanitize(message.summary)?no_esc}</p>
                    </div>
                </div>
            <#elseif message?has_content && message.type == 'info'>
                <div class="p-4 rounded-lg bg-blue-50 border border-blue-200 text-blue-700 text-sm flex items-start gap-3">
                    <span class="material-icons-round text-blue-500 text-xl flex-shrink-0">info</span>
                    <div>
                        <p class="font-medium">Informasi</p>
                        <p class="text-blue-600">${kcSanitize(message.summary)?no_esc}</p>
                    </div>
                </div>
            </#if>

            <div class="space-y-1">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="username">${msg("usernameOrEmail")}</label>
                <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 text-sm <#if messagesPerField.existsError('username')>border-red-500</#if>"
                    id="username" 
                    name="username"
                    placeholder="username@jogjaprov.go.id" 
                    type="text"
                    autofocus
                    value="${(auth.attemptedUsername!'')}"
                    aria-invalid="<#if messagesPerField.existsError('username')>true</#if>" />
            </div>

            <button class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors"
                type="submit">
                <span class="material-icons-round mr-2 text-xl">send</span>
                ${msg("sendVerificationCode")}
            </button>
        </form>

        <a href="${url.loginUrl}" class="mt-8 inline-flex items-center text-sm text-gray-500 dark:text-gray-400 hover:text-primary dark:hover:text-accent">
            <span class="material-icons-round mr-1 text-lg">arrow_back</span>
            ${msg("backToLogin")}
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
            <#-- Slide 1: Keamanan Akun -->
            <div class="insight-slide active" data-slide="0">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Keamanan</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Amankan Akun <br />
                        <span class="text-primary/70 italic font-light">Dengan Langkah Mudah</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Reset password dengan aman melalui verifikasi email. Kami memastikan hanya Anda yang dapat mengakses akun Anda.
                    </p>
                </div>
            </div>
            <#-- Slide 2: 2FA -->
            <div class="insight-slide" data-slide="1">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">2FA</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Aktifkan Verifikasi <br />
                        <span class="text-primary/70 italic font-light">Dua Langkah (2FA)</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Tingkatkan keamanan akun Anda dengan mengaktifkan autentikasi dua faktor setelah mereset password.
                    </p>
                </div>
            </div>
            <#-- Slide 3: Tips Password -->
            <div class="insight-slide" data-slide="2">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Tips</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Password Kuat <br />
                        <span class="text-primary/70 italic font-light">Minimal 8 Karakter</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Gunakan kombinasi huruf besar, huruf kecil, angka, dan simbol untuk password yang lebih aman.
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
