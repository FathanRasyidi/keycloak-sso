<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('totp','userLabel'); section>
    <#if section = "form">
        <style>
            /* Animasi Melayang */
            @keyframes float {
                0%, 100% { transform: translateY(0) scale(1); }
                50% { transform: translateY(-8px) scale(1.02); }
            }
            .qr-float { animation: float 3s ease-in-out infinite; }

            /* Efek Glow */
            @keyframes glow-pulse {
                0%, 100% { box-shadow: 0 8px 32px rgba(74, 28, 111, 0.2), 0 0 0 0 rgba(74, 28, 111, 0.3); }
                50% { box-shadow: 0 12px 48px rgba(74, 28, 111, 0.4), 0 0 30px 5px rgba(74, 28, 111, 0.2); }
            }
            .glow-pulse { animation: glow-pulse 2s ease-in-out infinite; }

            /* Animasi Step */
            @keyframes slide-in {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }
            .step-section {
                animation: slide-in 0.5s ease-out forwards;
                opacity: 0;
            }
            .step-section:nth-child(1) { animation-delay: 0.1s; }
            .step-section:nth-child(2) { animation-delay: 0.2s; }
            .step-section:nth-child(3) { animation-delay: 0.3s; }

            /* Fade In */
            @keyframes fade-in-up {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }
            .fade-in-up { animation: fade-in-up 0.6s ease-out forwards; }

            /* OTP Box Input */
            .otp-container {
                display: flex;
                gap: 10px;
                justify-content: center;
            }
            .otp-box {
                width: 48px;
                height: 56px;
                text-align: center;
                font-size: 1.5rem;
                font-weight: 600;
                border: 1px solid #e5e7eb;
                border-radius: 8px;
                background: #f9fafb;
                transition: all 0.2s ease;
                font-family: ui-monospace, SFMono-Regular, monospace;
                color: #1f2937;
            }
            .otp-box:focus {
                border-color: #4A1C6F;
                box-shadow: 0 0 0 3px rgba(74, 28, 111, 0.1);
                outline: none;
                background: white;
                transform: scale(1.05);
            }
            .otp-box.filled {
                border-color: #4A1C6F;
                background: white;
            }
            .otp-box.error {
                border-color: #ef4444;
                background: #fef2f2;
            }
        </style>

        <div class="mb-0 text-center fade-in-up">
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white">Aktifkan Autentikasi 2 Faktor</h1>
        </div>

        <#-- Alert Messages -->
        <#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
            <div class="p-4 rounded-xl mb-2 <#if message.type = 'success'>bg-green-50 border border-green-200 text-green-700<#elseif message.type = 'warning'>bg-yellow-50 border border-yellow-200 text-yellow-700<#elseif message.type = 'error'>bg-red-50 border border-red-200 text-red-700<#else>bg-blue-50 border border-blue-200 text-blue-700</#if> text-sm flex items-start gap-3">
                <span class="material-icons-round text-xl flex-shrink-0">
                    <#if message.type = 'success'>check_circle<#elseif message.type = 'warning'>warning<#elseif message.type = 'error'>error<#else>info</#if>
                </span>
                <div>
                    <p class="font-medium">${kcSanitize(message.summary)?no_esc}</p>
                </div>
            </div>
        </#if>

        <#-- Form -->
        <form action="${url.loginAction}" class="space-y-5" method="post" id="kc-totp-settings-form">
            <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
            <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
            <input type="hidden" id="totp" name="totp" value="" />

            <#-- Main Card with All Steps -->
            <div class="bg-surface-light dark:bg-surface-dark rounded-2xl p-5 border border-gray-200 dark:border-gray-700 space-y-5">
                
                <#-- Step 1: Description -->
                <div class="flex items-start gap-4">
                    <span class="w-8 h-8 bg-primary text-white rounded-full flex items-center justify-center text-sm font-bold flex-shrink-0">1</span>
                    <div class="flex-1">
                        <h3 class="text-sm font-semibold text-gray-800 dark:text-gray-200 mb-2">Siapkan Aplikasi Authenticator</h3>
                        <p class="text-sm text-gray-600 dark:text-gray-400 leading-relaxed">
                            Unduh aplikasi seperti <strong>Google Authenticator</strong>, <strong>Microsoft Authenticator</strong>, atau <strong>FreeOTP</strong>.
                        </p>
                    </div>
                </div>

                <hr class="border-gray-200 dark:border-gray-700" />

                <#-- Step 2: QR Code Section -->
                <div class="flex items-start gap-4 mb-4">
                    <span class="w-8 h-8 bg-primary text-white rounded-full flex items-center justify-center text-sm font-bold flex-shrink-0">2</span>
                    <div class="flex-1">
                        <h3 class="text-sm font-semibold text-gray-800 dark:text-gray-200 mb-2">Pindai QR Code</h3>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Buka aplikasi authenticator dan pindai QR code di bawah.</p>
                    </div>
                </div>
                <div class="flex flex-col items-center">
                    <div class="relative bg-white dark:bg-gray-800 p-3 rounded-xl shadow-lg qr-float glow-pulse">
                        <img id="kc-totp-secret-qr-code" 
                             src="data:image/png;base64, ${totp.totpSecretQrCode}" 
                             alt="QR Code" 
                             class="w-48 h-48"
                             style="image-rendering: pixelated;" />
                    </div>
                    <#-- Manual Code -->
                    <div class="mt-4 w-full p-3 bg-gray-50 dark:bg-gray-800/50 rounded-lg border border-gray-200 dark:border-gray-700">
                        <p class="text-xs text-gray-500 dark:text-gray-400 mb-2 text-center">Tidak bisa scan? Masukkan kode ini:</p>
                        <code class="block w-full bg-white dark:bg-gray-900 px-3 py-2 rounded-md text-sm font-mono text-gray-800 dark:text-gray-200 border border-gray-200 dark:border-gray-700 break-all select-all text-center tracking-wider">${totp.totpSecretEncoded}</code>
                    </div>
                </div>

                <hr class="border-gray-200 dark:border-gray-700" />

                <#-- Step 3: OTP Input Section -->
                <div class="flex items-start gap-4 mb-4">
                    <span class="w-8 h-8 bg-primary text-white rounded-full flex items-center justify-center text-sm font-bold flex-shrink-0">3</span>
                    <div class="flex-1">
                        <h3 class="text-sm font-semibold text-gray-800 dark:text-gray-200 mb-2">Masukkan Kode Verifikasi</h3>
                        <p class="text-sm text-gray-600 dark:text-gray-400">Masukkan kode 6 digit dari aplikasi authenticator.</p>
                    </div>
                </div>
                <div class="otp-container">
                    <input type="text" maxlength="1" class="otp-box <#if messagesPerField.existsError('totp')>error</#if>" data-index="0" inputmode="numeric" pattern="[0-9]*" autofocus />
                    <input type="text" maxlength="1" class="otp-box <#if messagesPerField.existsError('totp')>error</#if>" data-index="1" inputmode="numeric" pattern="[0-9]*" />
                    <input type="text" maxlength="1" class="otp-box <#if messagesPerField.existsError('totp')>error</#if>" data-index="2" inputmode="numeric" pattern="[0-9]*" />
                    <input type="text" maxlength="1" class="otp-box <#if messagesPerField.existsError('totp')>error</#if>" data-index="3" inputmode="numeric" pattern="[0-9]*" />
                    <input type="text" maxlength="1" class="otp-box <#if messagesPerField.existsError('totp')>error</#if>" data-index="4" inputmode="numeric" pattern="[0-9]*" />
                    <input type="text" maxlength="1" class="otp-box <#if messagesPerField.existsError('totp')>error</#if>" data-index="5" inputmode="numeric" pattern="[0-9]*" />
                </div>
                <#if messagesPerField.existsError('totp')>
                    <p class="text-xs text-red-500 mt-2 text-center flex items-center justify-center gap-1">
                        <span class="material-icons-round text-sm">error</span>
                        ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                    </p>
                </#if>
            </div>

            <#-- Device Name Input -->
            <div class="space-y-2">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="userLabel">
                    Nama Perangkat <#if totp.otpCredentials?size gte 1><span class="text-red-500">*</span></#if>
                </label>
                <div class="relative">
                    <span class="material-icons-round absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 text-xl">devices</span>
                    <input
                        class="w-full pl-12 pr-4 py-3 rounded-xl bg-surface-light dark:bg-surface-dark border <#if messagesPerField.existsError('userLabel')>border-red-500<#else>border-gray-200 dark:border-gray-700</#if> focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 dark:placeholder-gray-500 text-sm"
                        id="userLabel" 
                        name="userLabel"
                        type="text"
                        placeholder="Contoh: iPhone Pribadi, Samsung Galaxy"
                        autocomplete="off"
                        <#if totp.otpCredentials?size gte 1>required</#if>
                        aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>" />
                </div>
                <#if messagesPerField.existsError('userLabel')>
                    <p class="text-xs text-red-500 mt-1 flex items-center gap-1">
                        <span class="material-icons-round text-sm">error</span>
                        ${kcSanitize(messagesPerField.get('userLabel'))?no_esc}
                    </p>
                </#if>
            </div>

            <#-- Logout from other devices -->
            <div class="flex items-center">
                <input class="h-4 w-4 text-primary border-gray-300 rounded focus:ring-primary dark:bg-surface-dark dark:border-gray-600"
                    id="logout-sessions" 
                    name="logout-sessions" 
                    type="checkbox"
                    value="on"
                    checked />
                <label class="ml-2 block text-sm text-gray-600 dark:text-gray-300" for="logout-sessions">
                    Keluar dari perangkat lain
                </label>
            </div>

            <#-- Action Buttons -->
            <div class="flex gap-3 pt-2">
                <#if isAppInitiatedAction??>
                    <button
                        class="flex-1 flex justify-center items-center py-3 px-4 border border-gray-300 dark:border-gray-600 rounded-xl shadow-sm text-sm font-medium text-gray-700 dark:text-gray-300 bg-white dark:bg-gray-800 hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 transition-colors"
                        type="submit"
                        name="cancel-aia"
                        value="true">
                        Batal
                    </button>
                </#if>
                <button
                    class="flex-1 flex justify-center items-center py-3.5 px-4 border border-transparent rounded-xl shadow-sm text-sm font-semibold text-white bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors"
                    type="submit"
                    id="saveTOTPBtn">
                    Aktifkan 2FA
                </button>
            </div>
        </form>

        <script>
            // OTP Box Input Logic
            (function() {
                const otpBoxes = document.querySelectorAll('.otp-box');
                const hiddenInput = document.getElementById('totp');

                function updateHiddenInput() {
                    let value = '';
                    otpBoxes.forEach(function(box) { value += box.value; });
                    hiddenInput.value = value;
                }

                otpBoxes.forEach(function(box, index) {
                    box.addEventListener('input', function(e) {
                        const value = e.target.value.replace(/[^0-9]/g, '');
                        e.target.value = value;
                        
                        if (value) {
                            e.target.classList.add('filled');
                            if (index < otpBoxes.length - 1) {
                                otpBoxes[index + 1].focus();
                            }
                        } else {
                            e.target.classList.remove('filled');
                        }
                        updateHiddenInput();
                    });

                    box.addEventListener('keydown', function(e) {
                        if (e.key === 'Backspace' && !e.target.value && index > 0) {
                            otpBoxes[index - 1].focus();
                            otpBoxes[index - 1].value = '';
                            otpBoxes[index - 1].classList.remove('filled');
                            updateHiddenInput();
                        }
                        if (e.key === 'ArrowLeft' && index > 0) {
                            otpBoxes[index - 1].focus();
                        }
                        if (e.key === 'ArrowRight' && index < otpBoxes.length - 1) {
                            otpBoxes[index + 1].focus();
                        }
                    });

                    box.addEventListener('paste', function(e) {
                        e.preventDefault();
                        const paste = (e.clipboardData || window.clipboardData).getData('text').replace(/[^0-9]/g, '');
                        paste.split('').forEach(function(char, i) {
                            if (otpBoxes[index + i]) {
                                otpBoxes[index + i].value = char;
                                otpBoxes[index + i].classList.add('filled');
                            }
                        });
                        const nextIndex = Math.min(index + paste.length, otpBoxes.length - 1);
                        otpBoxes[nextIndex].focus();
                        updateHiddenInput();
                    });

                    box.addEventListener('focus', function() {
                        box.select();
                    });
                });
            })();
        </script>

    <#elseif section = "footer">
        <p class="text-sm text-gray-500 dark:text-gray-400">
            Butuh Bantuan? 
            <a class="font-medium text-primary dark:text-accent hover:underline" href="https://discord.com/servers/diskominfo-diy-905311916359041064" target="_blank" rel="noopener noreferrer">Hubungi Support!</a>
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
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Keamanan</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Autentikasi <br />
                        <span class="text-primary/70 italic font-light">Dua Faktor</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Lindungi akun Anda dengan lapisan keamanan ekstra menggunakan kode OTP dari aplikasi authenticator.
                    </p>
                </div>
            </div>
            <#-- Slide 2 -->
            <div class="insight-slide" data-slide="1">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Proteksi</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Akun Lebih Aman <br />
                        <span class="text-primary/70 italic font-light">dari Ancaman</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Dengan 2FA, meski kata sandi bocor, akun Anda tetap terlindungi karena membutuhkan kode unik dari perangkat Anda.
                    </p>
                </div>
            </div>
            <#-- Slide 3 -->
            <div class="insight-slide" data-slide="2">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Praktis</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Mudah Digunakan <br />
                        <span class="text-primary/70 italic font-light">Kapan Saja</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Cukup buka aplikasi authenticator di ponsel Anda dan masukkan kode 6 digit yang muncul.
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
