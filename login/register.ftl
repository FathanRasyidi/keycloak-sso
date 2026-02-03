<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('firstName','lastName','email','username','password','password-confirm') displayRequiredFields=true; section>
    <#if section = "form">
        <div class="mb-6">
            <h1 class="text-3xl sm:text-4xl font-bold mb-3 text-gray-900 dark:text-white">${msg("registerTitle")}</h1>
            <p class="text-gray-500 dark:text-gray-400">${msg("registerSubtitle")}</p>
        </div>

        <form action="${url.registrationAction}" class="space-y-4" method="POST" id="kc-register-form">
            <#-- Alert Error -->
            <#if message?has_content && (message.type == 'error' || message.type == 'warning')>
                <div class="p-4 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm flex items-start gap-3">
                    <span class="material-icons-round text-red-500 text-xl flex-shrink-0">error</span>
                    <div>
                        <p class="font-medium">Pendaftaran Gagal</p>
                        <p class="text-red-600">Tolong isi semua field yang dibutuhkan</p>
                    </div>
                </div>
            </#if>

            <#-- Input Nama -->
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div class="space-y-1">
                    <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="firstName">${msg("firstName")}</label>
                    <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 dark:placeholder-gray-500 text-sm <#if messagesPerField.existsError('firstName')>border-red-500</#if>"
                        id="firstName" 
                        name="firstName" 
                        placeholder="Nama depan" 
                        type="text"
                        value="${(register.formData.firstName!'')}"
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
                        placeholder="Nama belakang" 
                        type="text"
                        value="${(register.formData.lastName!'')}"
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
                        value="${(register.formData.username!'')}"
                        autocomplete="username"
                        aria-invalid="<#if messagesPerField.existsError('username')>true</#if>" />
                    <#if messagesPerField.existsError('username')>
                        <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('username'))?no_esc}</p>
                    </#if>
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
                    value="${(register.formData.email!'')}"
                    autocomplete="email"
                    aria-invalid="<#if messagesPerField.existsError('email')>true</#if>" />
                <#if messagesPerField.existsError('email')>
                    <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('email'))?no_esc}</p>
                </#if>
            </div>

            <#if passwordRequired??>
                <#-- Input Password -->
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div class="space-y-1">
                        <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="password">${msg("passwordNew")}</label>
                        <div class="relative">
                            <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 dark:placeholder-gray-500 text-sm pr-12 <#if messagesPerField.existsError('password')>border-red-500</#if>"
                                id="password" 
                                name="password" 
                                placeholder="••••••••" 
                                type="password"
                                autocomplete="new-password"
                                aria-invalid="<#if messagesPerField.existsError('password')>true</#if>" />
                            <button type="button"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300"
                                onclick="togglePasswordVisibility('password', this)">
                                <span class="material-icons-round text-xl">visibility_off</span>
                            </button>
                        </div>
                        <#if messagesPerField.existsError('password')>
                            <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('password'))?no_esc}</p>
                        </#if>
                    </div>
                    <div class="space-y-1">
                        <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="password-confirm">${msg("passwordConfirm")}</label>
                        <div class="relative">
                            <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 dark:placeholder-gray-500 text-sm pr-12 <#if messagesPerField.existsError('password-confirm')>border-red-500</#if>"
                                id="password-confirm" 
                                name="password-confirm" 
                                placeholder="••••••••"
                                type="password"
                                autocomplete="new-password"
                                aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>" />
                            <button type="button"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300"
                                onclick="togglePasswordVisibility('password-confirm', this)">
                                <span class="material-icons-round text-xl">visibility_off</span>
                            </button>
                        </div>
                        <#if messagesPerField.existsError('password-confirm')>
                            <p class="text-xs text-red-500 mt-1">${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}</p>
                        </#if>
                    </div>
                </div>

                <#-- Syarat Password -->
                <div class="bg-surface-light dark:bg-surface-dark rounded-lg p-3 border border-gray-200 dark:border-gray-700">
                    <p class="text-xs font-medium text-gray-600 dark:text-gray-400 mb-2">${msg("passwordRequirements")}</p>
                    <ul class="text-xs text-gray-500 dark:text-gray-400 space-y-1">
                        <li class="flex items-center gap-2" id="req-length">
                            <span class="material-icons-round text-sm text-gray-400">radio_button_unchecked</span>
                            ${msg("passwordMinLength")}
                        </li>
                        <li class="flex items-center gap-2" id="req-uppercase">
                            <span class="material-icons-round text-sm text-gray-400">radio_button_unchecked</span>
                            ${msg("passwordUppercase")}
                        </li>
                        <li class="flex items-center gap-2" id="req-number">
                            <span class="material-icons-round text-sm text-gray-400">radio_button_unchecked</span>
                            ${msg("passwordNumber")}
                        </li>
                        <li class="flex items-center gap-2" id="req-special">
                            <span class="material-icons-round text-sm text-gray-400">radio_button_unchecked</span>
                            ${msg("passwordSpecial")}
                        </li>
                    </ul>
                </div>
            </#if>

            <#-- Syarat & Ketentuan -->
            <div class="flex items-start">
                <input class="h-4 w-4 mt-1 text-primary border-gray-300 rounded focus:ring-primary dark:bg-surface-dark dark:border-gray-600"
                    id="terms" 
                    name="terms" 
                    type="checkbox" />
                <label class="ml-2 block text-xs text-gray-500 dark:text-gray-400 leading-tight" for="terms">
                    Saya menyetujui <a class="text-primary dark:text-accent hover:underline" href="#">${msg("termsOfUse")}</a> ${msg("and")} <a class="text-primary dark:text-accent hover:underline" href="#">${msg("privacyPolicy")}</a> PEMDA DIY.
                </label>
            </div>

            <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                    </div>
                </div>
            </#if>

            <button class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors"
                type="submit">
                ${msg("registerButton")}
            </button>
        </form>

    <#elseif section = "footer">
        <p class="text-sm text-gray-500 dark:text-gray-400">
            ${msg("alreadyHaveAccount")}
            <a class="font-medium text-primary dark:text-accent hover:underline" href="${url.loginUrl}">${msg("loginHere")}</a>
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
            <#-- Slide 1: Bergabung -->
            <div class="insight-slide active" data-slide="0">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Bergabung</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Bergabunglah dengan <br />
                        <span class="text-primary/70 italic font-light">Yogyakarta Digital</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Daftarkan diri Anda dan nikmati kemudahan akses ke seluruh layanan digital PEMDA DIY dalam satu akun terintegrasi.
                    </p>
                </div>
            </div>
            <#-- Slide 2: Ratusan Layanan -->
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
            <#-- Slide 3: Keamanan -->
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
        <script>
            // Validasi password real-time
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('password-confirm');

            if (passwordInput) {
                passwordInput.addEventListener('input', function () {
                    const password = this.value;
                    updateRequirement('req-length', password.length >= 8);
                    updateRequirement('req-uppercase', /[A-Z]/.test(password));
                    updateRequirement('req-number', /[0-9]/.test(password));
                    updateRequirement('req-special', /[!@#$%^&*]/.test(password));
                    checkPasswordMatch();
                });
            }

            if (confirmPasswordInput) {
                confirmPasswordInput.addEventListener('input', checkPasswordMatch);
            }

            function checkPasswordMatch() {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('password-confirm').value;
                const confirmField = document.getElementById('password-confirm');

                if (confirmPassword && password !== confirmPassword) {
                    confirmField.classList.add('border-red-500');
                    confirmField.classList.remove('border-gray-200');
                } else if (confirmPassword && password === confirmPassword) {
                    confirmField.classList.add('border-green-500');
                    confirmField.classList.remove('border-red-500', 'border-gray-200');
                } else {
                    confirmField.classList.remove('border-red-500', 'border-green-500');
                    confirmField.classList.add('border-gray-200');
                }
            }

            function updateRequirement(id, valid) {
                const element = document.getElementById(id);
                if (!element) return;
                const icon = element.querySelector('.material-icons-round');

                if (valid) {
                    icon.textContent = 'check_circle';
                    icon.classList.remove('text-gray-400');
                    icon.classList.add('text-green-500');
                } else {
                    icon.textContent = 'radio_button_unchecked';
                    icon.classList.remove('text-green-500');
                    icon.classList.add('text-gray-400');
                }
            }
        </script>
    </#if>
</@layout.registrationLayout>
