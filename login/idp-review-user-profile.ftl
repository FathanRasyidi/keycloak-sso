<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username') displayRequiredFields=true; section>
    <#if section = "form">
        <div class="mb-6">
            <#-- Show social provider info -->
            <#-- Info box -->
            <div class="bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 rounded-lg p-4 mb-5">
                <div class="flex items-start gap-3">
                    <span class="material-icons-round text-blue-500 text-xl flex-shrink-0">info</span>
                    <div>
                        <#-- Get provider ID from updateProfileCtx -->
                        <#assign providerInfo = "">
                        <#if updateProfileCtx?? && updateProfileCtx.identityProviderId??>
                            <#assign providerInfo = updateProfileCtx.identityProviderId?lower_case>
                        </#if>
                        
                        <#-- Check for GitHub -->
                        <#if providerInfo == "github" || providerInfo?contains("github")>
                            <p class="text-sm font-medium text-blue-800 dark:text-blue-200">${msg("welcomeGithub")}</p>
                            <p class="text-xs text-blue-600 dark:text-blue-300 mt-1">${msg("linkedWithGithub")}.</p>
                        <#-- Check for Google -->
                        <#elseif providerInfo == "google" || providerInfo?contains("google")>
                            <p class="text-sm font-medium text-blue-800 dark:text-blue-200">${msg("welcomeGoogle")}</p>
                            <p class="text-xs text-blue-600 dark:text-blue-300 mt-1">${msg("linkedWithGoogle")}.</p>
                        <#-- Check for Facebook -->
                        <#elseif providerInfo == "facebook" || providerInfo?contains("facebook")>
                            <p class="text-sm font-medium text-blue-800 dark:text-blue-200">${msg("welcomeFacebook", "Selamat datang!")}</p>
                            <p class="text-xs text-blue-600 dark:text-blue-300 mt-1">${msg("linkedWithFacebook", "Akun Anda terhubung dengan Facebook")}.</p>
                        <#-- Default for other social providers -->
                        <#else>
                            <p class="text-sm font-medium text-blue-800 dark:text-blue-200">${msg("welcomeSocial")}</p>
                            <p class="text-xs text-blue-600 dark:text-blue-300 mt-1">${msg("linkedWithSocial")}.</p>
                        </#if>
                    </div>
                </div>
            </div>

            <h1 class="text-3xl sm:text-4xl font-bold mb-3 text-gray-900 dark:text-white">${msg("updateProfileTitle")}</h1>
            <p class="text-gray-500 dark:text-gray-400">${msg("updateProfileSubtitle")}</p>
        </div>

        <form action="${url.loginAction}" class="space-y-4" method="POST" id="kc-idp-review-profile-form">
            <#-- Alert Error -->
            <#if message?has_content && (message.type == 'error' || message.type == 'warning')>
                <div class="p-4 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm flex items-start gap-3">
                    <span class="material-icons-round text-red-500 text-xl flex-shrink-0">error</span>
                    <div>
                        <p class="font-medium">Kesalahan</p>
                        <p class="text-red-600">${kcSanitize(message.summary)?no_esc}</p>
                    </div>
                </div>
            </#if>

            <#-- Input Email -->
            <div class="space-y-1">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="email">${msg("email")}</label>
                <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 dark:placeholder-gray-500 text-sm <#if messagesPerField.existsError('email')>border-red-500</#if>"
                    id="email" 
                    name="email" 
                    placeholder="email@jogjaprov.go.id" 
                    type="email"
                    value="${(user.email!'')}"
                    autocomplete="email"
                    readonly
                    aria-invalid="<#if messagesPerField.existsError('email')>true</#if>" />
                <#if messagesPerField.existsError('email')>
                    <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('email'))?no_esc}</p>
                </#if>
            </div>

            <#-- Input Nama -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div class="space-y-1">
                    <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="firstName">${msg("firstName")}</label>
                    <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 dark:placeholder-gray-500 text-sm <#if messagesPerField.existsError('firstName')>border-red-500</#if>"
                        id="firstName" 
                        name="firstName" 
                        placeholder="Nama depan" 
                        type="text"
                        value="${(user.firstName!'')}"
                        aria-invalid="<#if messagesPerField.existsError('firstName')>true</#if>" />
                    <#if messagesPerField.existsError('firstName')>
                        <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('firstName'))?no_esc}</p>
                    </#if>
                </div>
                <div class="space-y-1">
                    <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="lastName">${msg("lastName")}</label>
                    <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 dark:placeholder-gray-500 text-sm <#if messagesPerField.existsError('lastName')>border-red-500</#if>"
                        id="lastName" 
                        name="lastName" 
                        placeholder="Nama belakang (opsional)" 
                        type="text"
                        value="${(user.lastName!'')}"
                        aria-invalid="<#if messagesPerField.existsError('lastName')>true</#if>" />
                    <#if messagesPerField.existsError('lastName')>
                        <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('lastName'))?no_esc}</p>
                    </#if>
                </div>
            </div>

            <#-- Input Username -->
            <#if !realm.registrationEmailAsUsername>
                <div class="space-y-1">
                    <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="username">${msg("username")}</label>
                    <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 dark:placeholder-gray-500 text-sm <#if messagesPerField.existsError('username')>border-red-500</#if>"
                        id="username" 
                        name="username" 
                        placeholder="Masukkan username (3-20 karakter)" 
                        type="text"
                        value="${(user.username!'')}"
                        autocomplete="username"
                        aria-invalid="<#if messagesPerField.existsError('username')>true</#if>" />
                    <#if messagesPerField.existsError('username')>
                        <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('username'))?no_esc}</p>
                    </#if>
                    <p class="text-xs text-gray-400 mt-1">Username akan digunakan untuk login ke sistem SSO PEMDA DIY</p>
                </div>
            </#if>

            <button class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors"
                type="submit">
                ${msg("updateProfileButton")}
            </button>
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
        <#-- Slider Container -->
        <div class="insight-slider relative overflow-hidden">
            <div class="insight-slide active" data-slide="0">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Integrasi</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Terhubung dengan <br />
                        <span class="text-primary/70 italic font-light">GitHub & Social Login</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Login lebih mudah dengan akun GitHub atau media sosial lainnya yang terintegrasi dengan sistem SSO.
                    </p>
                </div>
            </div>
            <div class="insight-slide" data-slide="1">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Layanan</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Ratusan Layanan <br />
                        <span class="text-primary/70 italic font-light">Dalam Satu Akun</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Akses e-Kinerja, SIMPEG, e-Office, dan berbagai layanan lainnya tanpa perlu login berulang kali.
                    </p>
                </div>
            </div>
            <div class="insight-slide" data-slide="2">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Aman</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Data Anda Aman <br />
                        <span class="text-primary/70 italic font-light">Terenkripsi & Terlindungi</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Sistem keamanan berlapis melindungi data pribadi Anda dengan standar enkripsi terbaik.
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
