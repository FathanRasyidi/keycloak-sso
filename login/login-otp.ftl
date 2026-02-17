<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp'); section>
    <#if section = "form">
        <div class="mb-8">
            <div class="w-16 h-16 bg-primary/10 dark:bg-accent/10 rounded-full flex items-center justify-center mb-6">
                <span class="material-icons-round text-3xl text-primary dark:text-accent">phonelink_lock</span>
            </div>
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white">Verifikasi Kode</h1>
            <p class="text-gray-500 dark:text-gray-400">Masukkan kode 6 digit dari aplikasi authenticator Anda</p>
        </div>

        <form action="${url.loginAction}" class="space-y-5" method="post" id="kc-otp-login-form">
            <#-- Alert Messages -->
            <#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                <div class="p-4 rounded-lg <#if message.type = 'success'>bg-green-50 border border-green-200 text-green-700<#elseif message.type = 'warning'>bg-yellow-50 border border-yellow-200 text-yellow-700<#elseif message.type = 'error'>bg-red-50 border border-red-200 text-red-700<#else>bg-blue-50 border border-blue-200 text-blue-700</#if> text-sm flex items-start gap-3">
                    <span class="material-icons-round text-xl flex-shrink-0">
                        <#if message.type = 'success'>check_circle<#elseif message.type = 'warning'>warning<#elseif message.type = 'error'>error<#else>info</#if>
                    </span>
                    <div>
                        <p class="font-medium">${kcSanitize(message.summary)?no_esc}</p>
                    </div>
                </div>
            </#if>

            <#-- Hidden input for actual OTP value -->
            <input type="hidden" id="otp" name="otp" value="" />

            <#-- Multiple OTP Credentials Selection -->
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="space-y-2">
                    <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300">Pilih Perangkat</label>
                    <div class="grid gap-2">
                        <#list otpLogin.userOtpCredentials as otpCredential>
                            <label class="relative flex items-center p-3 rounded-lg border cursor-pointer transition-all
                                <#if otpCredential.id == otpLogin.selectedCredentialId>
                                    border-primary bg-primary/5 dark:bg-primary/10
                                <#else>
                                    border-gray-200 dark:border-gray-700 hover:border-primary/50 hover:bg-gray-50 dark:hover:bg-gray-800
                                </#if>">
                                <input 
                                    type="radio" 
                                    id="kc-otp-credential-${otpCredential?index}" 
                                    name="selectedCredentialId" 
                                    value="${otpCredential.id}"
                                    class="sr-only"
                                    <#if otpCredential.id == otpLogin.selectedCredentialId>checked="checked"</#if> />
                                <div class="w-8 h-8 rounded-lg bg-primary/10 dark:bg-primary/20 flex items-center justify-center mr-3">
                                    <span class="material-icons-round text-lg text-primary">smartphone</span>
                                </div>
                                <div class="flex-1">
                                    <p class="text-sm font-medium text-gray-800 dark:text-gray-200">${otpCredential.userLabel}</p>
                                </div>
                                <div class="w-4 h-4 rounded-full border-2 flex items-center justify-center
                                    <#if otpCredential.id == otpLogin.selectedCredentialId>
                                        border-primary bg-primary
                                    <#else>
                                        border-gray-300 dark:border-gray-600
                                    </#if>">
                                    <#if otpCredential.id == otpLogin.selectedCredentialId>
                                        <span class="material-icons-round text-[10px] text-white">check</span>
                                    </#if>
                                </div>
                            </label>
                        </#list>
                    </div>
                </div>
            </#if>

            <#-- OTP Input Boxes -->
            <div class="flex justify-center gap-2" id="otp-inputs">
                <input type="text" maxlength="1" class="w-12 h-14 text-center text-2xl font-bold rounded-lg bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('totp')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none dark:text-white" data-index="0" inputmode="numeric" pattern="[0-9]*" autofocus />
                <input type="text" maxlength="1" class="w-12 h-14 text-center text-2xl font-bold rounded-lg bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('totp')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none dark:text-white" data-index="1" inputmode="numeric" pattern="[0-9]*" />
                <input type="text" maxlength="1" class="w-12 h-14 text-center text-2xl font-bold rounded-lg bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('totp')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none dark:text-white" data-index="2" inputmode="numeric" pattern="[0-9]*" />
                <input type="text" maxlength="1" class="w-12 h-14 text-center text-2xl font-bold rounded-lg bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('totp')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none dark:text-white" data-index="3" inputmode="numeric" pattern="[0-9]*" />
                <input type="text" maxlength="1" class="w-12 h-14 text-center text-2xl font-bold rounded-lg bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('totp')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none dark:text-white" data-index="4" inputmode="numeric" pattern="[0-9]*" />
                <input type="text" maxlength="1" class="w-12 h-14 text-center text-2xl font-bold rounded-lg bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('totp')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none dark:text-white" data-index="5" inputmode="numeric" pattern="[0-9]*" />
            </div>

            <#-- Error Message -->
            <div id="otp_error_container" class="min-h-[20px]">
                <#if messagesPerField.existsError('totp')>
                    <p class="text-red-500 text-xs text-center flex items-center justify-center gap-1">
                        <span class="material-icons-round text-sm">error</span>
                        ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                    </p>
                </#if>
            </div>

            <#-- Verify Button -->
            <button
                class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors"
                type="submit"
                name="login">
                Verifikasi Kode
            </button>
        </form>

        <#-- Back to Login -->
        <a href="${url.loginRestartFlowUrl!url.loginUrl}" class="mt-8 inline-flex items-center text-sm text-gray-500 dark:text-gray-400 hover:text-primary dark:hover:text-accent">
            <span class="material-icons-round mr-1 text-lg">arrow_back</span>
            Kembali ke halaman login
        </a>

        <script>
            // OTP Box Input Logic
            (function() {
                const otpInputs = document.querySelectorAll('#otp-inputs input');
                const hiddenInput = document.getElementById('otp');

                function updateHiddenInput() {
                    let value = '';
                    otpInputs.forEach(function(input) { value += input.value; });
                    hiddenInput.value = value;
                }

                otpInputs.forEach(function(input, index) {
                    input.addEventListener('input', function(e) {
                        const value = e.target.value.replace(/[^0-9]/g, '').toUpperCase();
                        e.target.value = value;
                        
                        if (value.length === 1 && index < otpInputs.length - 1) {
                            otpInputs[index + 1].focus();
                        }
                        updateHiddenInput();

                        // Auto-submit when all 6 digits are entered
                        if (hiddenInput.value.length === 6) {
                            setTimeout(function() {
                                document.getElementById('kc-otp-login-form').submit();
                            }, 300);
                        }
                    });

                    input.addEventListener('keydown', function(e) {
                        if (e.key === 'Backspace' && !e.target.value && index > 0) {
                            otpInputs[index - 1].focus();
                            otpInputs[index - 1].value = '';
                            updateHiddenInput();
                        }
                        if (e.key === 'ArrowLeft' && index > 0) {
                            otpInputs[index - 1].focus();
                        }
                        if (e.key === 'ArrowRight' && index < otpInputs.length - 1) {
                            otpInputs[index + 1].focus();
                        }
                    });

                    input.addEventListener('paste', function(e) {
                        e.preventDefault();
                        const paste = (e.clipboardData || window.clipboardData).getData('text').replace(/[^0-9]/g, '');
                        paste.split('').forEach(function(char, i) {
                            if (otpInputs[index + i]) {
                                otpInputs[index + i].value = char;
                            }
                        });
                        const nextIndex = Math.min(index + paste.length, otpInputs.length - 1);
                        otpInputs[nextIndex].focus();
                        updateHiddenInput();

                        // Auto-submit when all 6 digits are pasted
                        if (hiddenInput.value.length === 6) {
                            setTimeout(function() {
                                document.getElementById('kc-otp-login-form').submit();
                            }, 300);
                        }
                    });

                    input.addEventListener('focus', function() {
                        input.select();
                    });
                });

                // Handle radio selection styling
                var radios = document.querySelectorAll('input[name="selectedCredentialId"]');
                radios.forEach(function(radio) {
                    radio.addEventListener('change', function() {
                        radios.forEach(function(r) {
                            var label = r.closest('label');
                            var indicator = label.querySelector('.w-4');
                            if (r.checked) {
                                label.classList.remove('border-gray-200');
                                label.classList.add('border-primary', 'bg-primary/5');
                                indicator.classList.remove('border-gray-300');
                                indicator.classList.add('border-primary', 'bg-primary');
                                indicator.innerHTML = '<span class="material-icons-round text-[10px] text-white">check</span>';
                            } else {
                                label.classList.add('border-gray-200');
                                label.classList.remove('border-primary', 'bg-primary/5');
                                indicator.classList.add('border-gray-300');
                                indicator.classList.remove('border-primary', 'bg-primary');
                                indicator.innerHTML = '';
                            }
                        });
                    });
                });
            })();
        </script>

    <#elseif section = "footer">
        <p class="text-sm text-gray-500 dark:text-gray-400">
            Butuh bantuan? 
            <a class="font-medium text-primary dark:text-accent hover:underline" href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank" rel="noopener noreferrer">Hubungi Support</a>
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
            <#-- Slide 1 -->
            <div class="insight-slide active" data-slide="0">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Verifikasi</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Satu Langkah Lagi <br />
                        <span class="text-primary/70 italic font-light">Menuju Akun Anda</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Masukkan kode 6 digit dari aplikasi authenticator Anda untuk memverifikasi identitas dan mengakses akun.
                    </p>
                </div>
            </div>
            <#-- Slide 2 -->
            <div class="insight-slide" data-slide="1">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Keamanan</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Akun Terlindungi <br />
                        <span class="text-primary/70 italic font-light">dengan 2FA</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Verifikasi dua langkah memastikan hanya Anda yang dapat mengakses akun, melindungi data dan privasi Anda.
                    </p>
                </div>
            </div>
            <#-- Slide 3 -->
            <div class="insight-slide" data-slide="2">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Cepat</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Proses Instan <br />
                        <span class="text-primary/70 italic font-light">Tanpa Ribet</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Cukup masukkan 6 digit kode dan Anda langsung masuk ke sistem. Cepat, aman, dan praktis.
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
    </#if>
</@layout.registrationLayout>
