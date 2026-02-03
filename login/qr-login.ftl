<#import "template.ftl" as layout>
<#import "qrLogin.ftl" as qrlogin>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "form">
        <div class="mb-8" id="welkam">
            <h1 class="text-3xl sm:text-4xl font-bold mb-3 text-gray-900 dark:text-white">${msg("loginWelcome")}</h1>
            <p class="text-gray-500 dark:text-gray-400">${msg("loginSubtitle")}</p>
        </div>

        <form action="${url.loginAction}" class="space-y-5" method="POST" id="kc-form-login">
            <#-- Alert Error -->
            <#if messagesPerField.existsError('username','password')>
                <div class="p-4 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm flex items-start gap-3">
                    <span class="material-icons-round text-red-500 text-xl flex-shrink-0">error</span>
                    <div>
                        <p class="font-medium">Login Gagal</p>
                        <p class="text-red-600">${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}</p>
                    </div>
                </div>
            <#elseif message?has_content && (message.type == 'error' || message.type == 'warning')>
                <div class="p-4 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm flex items-start gap-3">
                    <span class="material-icons-round text-red-500 text-xl flex-shrink-0">error</span>
                    <div>
                        <p class="font-medium">Login Gagal</p>
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
            </#if>

            <div class="space-y-1">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="username">${msg("usernameOrEmail")}</label>
                <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 dark:placeholder-gray-500 text-sm <#if messagesPerField.existsError('username','password')>border-red-500</#if>"
                    id="username" 
                    name="username" 
                    placeholder="username@jogjaprov.go.id" 
                    type="text" 
                    value="${(login.username!'')}"
                    autofocus 
                    autocomplete="username" />
            </div>

            <div class="space-y-1">
                <label class="block text-sm font-semibold text-gray-700 dark:text-gray-300" for="password">${msg("password")}</label>
                <div class="relative">
                    <input class="w-full px-4 py-3 rounded-lg bg-surface-light dark:bg-surface-dark border border-gray-200 dark:border-gray-700 focus:border-primary focus:ring-2 focus:ring-primary/20 outline-none transition-all dark:text-white placeholder-gray-400 dark:placeholder-gray-500 text-sm pr-12 <#if messagesPerField.existsError('username','password')>border-red-500</#if>"
                        id="password" 
                        name="password" 
                        placeholder="••••••••••••" 
                        type="password"
                        autocomplete="current-password" />
                    <button type="button"
                        class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 dark:hover:text-gray-300"
                        onclick="togglePasswordVisibility('password', this)">
                        <span class="material-icons-round text-xl">visibility_off</span>
                    </button>
                </div>
            </div>

            <div class="space-y-3">
                <div class="flex items-center justify-between">
                    <div class="flex items-center">
                        <#if realm.rememberMe && !usernameHidden??>
                            <input class="h-4 w-4 text-primary border-gray-300 rounded focus:ring-primary dark:bg-surface-dark dark:border-gray-600"
                                id="rememberMe" 
                                name="rememberMe" 
                                type="checkbox"
                                <#if login.rememberMe??>checked</#if> />
                            <label class="ml-2 block text-sm text-gray-600 dark:text-gray-300" for="rememberMe">${msg("rememberMe")}</label>
                        </#if>
                    </div>
                    <#if realm.resetPasswordAllowed>
                        <a href="${url.loginResetCredentialsUrl}" class="text-sm text-primary dark:text-accent hover:underline">${msg("forgotPassword")}</a>
                    </#if>
                </div>
            </div>

            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>

            <button class="w-full flex justify-center items-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors"
                type="submit" name="login">
                ${msg("loginButton")}
            </button>
        </form>

        <@qrlogin.qrLogin />

        <#-- Social Providers -->
        <#if realm.password && social?? && social.providers?has_content>
            <div id="opsional">
                <div class="relative my-8">
                    <div class="absolute inset-0 flex items-center">
                        <div class="w-full border-t border-gray-200 dark:border-gray-700"></div>
                    </div>
                    <div class="relative flex justify-center text-sm">
                        <span class="px-2 bg-background-light dark:bg-background-dark text-gray-400 uppercase text-xs font-medium tracking-wide">${msg("loginWith")}</span>
                    </div>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    <#-- Google provider first -->
                    <#list social.providers as p>
                        <#if p.alias == "google">
                            <a href="${p.loginUrl}"
                                class="w-full min-w-[140px] inline-flex justify-center items-center py-2.5 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm bg-white dark:bg-surface-dark text-sm font-medium text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                <svg aria-hidden="true" class="h-5 w-5 mr-2" viewBox="0 0 24 24">
                                    <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                                    <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                                    <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                                    <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
                                </svg>
                                <span>${p.displayName}</span>
                            </a>
                        </#if>
                    </#list>
                    
                    <#-- GitHub provider second -->
                    <#list social.providers as p>
                        <#if p.alias == "github">
                            <a href="${p.loginUrl}"
                                class="w-full min-w-[140px] inline-flex justify-center items-center py-2.5 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm bg-white dark:bg-surface-dark text-sm font-medium text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                <svg aria-hidden="true" class="h-5 w-5 mr-2" viewBox="0 0 24 24" fill="currentColor">
                                    <path fill-rule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clip-rule="evenodd"/>
                                </svg>
                                <span>${p.displayName}</span>
                            </a>
                        </#if>
                    </#list>
                    
                    <#-- Facebook provider -->
                    <#list social.providers as p>
                        <#if p.alias == "facebook">
                            <a href="${p.loginUrl}"
                                class="w-full min-w-[140px] inline-flex justify-center items-center py-2.5 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm bg-white dark:bg-surface-dark text-sm font-medium text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                <svg aria-hidden="true" class="h-5 w-5 mr-2" viewBox="0 0 24 24" fill="#1877F2">
                                    <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                                </svg>
                                <span>${p.displayName}</span>
                            </a>
                        </#if>
                    </#list>
                    
                    <#-- Other providers (if any) -->
                    <#list social.providers as p>
                        <#if p.alias != "google" && p.alias != "github" && p.alias != "facebook">
                            <a href="${p.loginUrl}"
                                class="w-full min-w-[140px] inline-flex justify-center items-center py-2.5 px-4 border border-gray-200 dark:border-gray-700 rounded-lg shadow-sm bg-white dark:bg-surface-dark text-sm font-medium text-gray-700 dark:text-gray-200 hover:bg-gray-50 dark:hover:bg-gray-700 transition-colors">
                                <span class="material-icons-round mr-2">login</span>
                                <span>${p.displayName}</span>
                            </a>
                        </#if>
                    </#list>
                </div>
            </div>
        </#if>

    <#elseif section = "footer">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <p class="text-sm text-gray-500 dark:text-gray-400">
                ${msg("noAccount")}
                <a class="font-medium text-primary dark:text-accent hover:underline" href="${url.registrationUrl}">${msg("registerHere")}</a>
            </p>
        </#if>
        
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
            <#-- Slide 1: Transformasi Digital -->
            <div class="insight-slide active" data-slide="0">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">E-Government</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Transformasi Digital <br />
                        <span class="text-primary/70 italic font-light">Yogyakarta Istimewa</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Mengintegrasikan teknologi informasi dalam tata kelola pemerintahan untuk mewujudkan pelayanan publik yang transparan, akuntabel, dan efisien.
                    </p>
                </div>
            </div>
            <#-- Slide 2: Layanan Terintegrasi -->
            <div class="insight-slide" data-slide="1">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Single Sign-On</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Layanan Terintegrasi <br />
                        <span class="text-primary/70 italic font-light">Satu Akun untuk Semua</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Akses ratusan layanan digital PEMDA DIY hanya dengan satu akun SSO. Praktis, cepat, dan terintegrasi dalam satu ekosistem digital.
                    </p>
                </div>
            </div>
            <#-- Slide 3: Keamanan Data -->
            <div class="insight-slide" data-slide="2">
                <div class="mb-6">
                    <span class="inline-block py-1 px-3 rounded bg-primary/10 text-primary text-[10px] font-bold tracking-widest uppercase mb-4">Keamanan</span>
                    <h2 class="text-4xl xl:text-5xl font-serif text-primary leading-tight mb-4 font-semibold">
                        Keamanan Data <br />
                        <span class="text-primary/70 italic font-light">Terpercaya & Terenkripsi</span>
                    </h2>
                    <p class="text-gray-600 text-base leading-relaxed mb-8 border-l-2 border-accent pl-4">
                        Data Anda dilindungi dengan enkripsi standar internasional dan sistem keamanan berlapis untuk menjamin privasi dan integritas informasi.
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
            function togglePasswordVisibility(inputId, button) {
                const input = document.getElementById(inputId);
                const icon = button.querySelector('.material-icons-round');
                if (input && icon) {
                    if (input.type === 'password') {
                        input.type = 'text';
                        icon.textContent = 'visibility';
                    } else {
                        input.type = 'password';
                        icon.textContent = 'visibility_off';
                    }
                }
            }

            function showQRModal() {
                const qrAuthData = document.getElementById('qr-auth-data');
                
                if (!qrAuthData) {
                    alert('QR Code extension belum dikonfigurasi.');
                    return;
                }

                const qrImage = qrAuthData.getAttribute('data-qr-image');
                const tabId = qrAuthData.getAttribute('data-tab-id') || 'N/A';
                const execId = qrAuthData.getAttribute('data-qr-exec-id') || '';

                if (!qrImage) {
                    alert('QR Code tidak tersedia. Silakan coba lagi.');
                    return;
                }

                const modalHTML = 
                    '<div id="qrModal" class="fixed inset-0 z-50 overflow-y-auto" style="display: block;">' +
                    '<div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">' +
                    '<div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" onclick="closeQRModal()"></div>' +
                    '<span class="hidden sm:inline-block sm:align-middle sm:h-screen">&#8203;</span>' +
                    '<div class="inline-block align-bottom bg-white dark:bg-surface-dark rounded-2xl text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">' +
                    '<div class="bg-white dark:bg-surface-dark px-6 pt-5 pb-4 sm:p-6">' +
                    '<div class="flex justify-between items-center mb-4">' +
                    '<h3 class="text-xl font-bold text-gray-900 dark:text-white">Login dengan QR Code</h3>' +
                    '<button onclick="closeQRModal()" class="text-gray-400 hover:text-gray-500">' +
                    '<span class="material-icons-round">close</span>' +
                    '</button>' +
                    '</div>' +
                    '<p class="text-gray-500 dark:text-gray-400 text-sm mb-6">Scan QR menggunakan aplikasi mobile PEMDA DIY</p>' +
                    '<div class="flex flex-col items-center">' +
                    '<div class="relative mb-6 bg-white dark:bg-gray-800 p-4 rounded-xl shadow-lg qr-float glow-pulse" id="qr-container">' +
                    '<img src="data:image/png;base64,' + qrImage + '" alt="QR Code" class="w-48 h-48 cursor-pointer hover:opacity-80 transition-opacity" onclick="document.getElementById(\'qr-submit-form\').submit();" />' +
                    '</div>' +
                    '<p class="text-sm text-gray-500 dark:text-gray-400 mb-2"><b>Session:</b> ' + tabId + '</p>' +
                    '<div id="qr-timer" class="flex items-center gap-2 text-sm text-gray-400 dark:text-gray-500 mb-6">' +
                    '<span class="material-icons-round text-base">schedule</span>' +
                    '<span id="timer-text">01:00</span>' +
                    '</div>' +
                    '<div class="w-full space-y-2">' +
                    '<h4 class="text-sm font-semibold text-gray-700 dark:text-gray-300">Cara Login:</h4>' +
                    '<div class="flex items-start gap-3 p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">' +
                    '<span class="w-6 h-6 bg-primary text-white rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0">1</span>' +
                    '<p class="text-sm text-gray-600 dark:text-gray-400">Buka aplikasi mobile PEMDA DIY</p>' +
                    '</div>' +
                    '<div class="flex items-start gap-3 p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">' +
                    '<span class="w-6 h-6 bg-primary text-white rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0">2</span>' +
                    '<p class="text-sm text-gray-600 dark:text-gray-400">Pilih menu "Scan QR"</p>' +
                    '</div>' +
                    '<div class="flex items-start gap-3 p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">' +
                    '<span class="w-6 h-6 bg-primary text-white rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0">3</span>' +
                    '<p class="text-sm text-gray-600 dark:text-gray-400">Arahkan kamera ke QR di layar</p>' +
                    '</div>' +
                    '<div class="flex items-start gap-3 p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">' +
                    '<span class="w-6 h-6 bg-primary text-white rounded-full flex items-center justify-center text-xs font-bold flex-shrink-0">4</span>' +
                    '<p class="text-sm text-gray-600 dark:text-gray-400">Setelah scan, klik QR code untuk melanjutkan</p>' +
                    '</div>' +
                    '</div>' +
                    '<form id="qr-submit-form" action="${url.loginAction}" method="post" style="display: none;">' +
                    '<input type="hidden" name="authenticationExecution" value="' + execId + '">' +
                    '</form>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>';
                
                document.body.insertAdjacentHTML('beforeend', modalHTML);
                document.body.style.overflow = 'hidden';

                // Start polling untuk check authentication status
                startQRPolling(execId);
            }

            function startQRPolling(execId) {
                let timeLeft = 60; // 60 detik
                
                // Update timer setiap detik
                const timerInterval = setInterval(function() {
                    timeLeft--;
                    const minutes = Math.floor(timeLeft / 60);
                    const seconds = timeLeft % 60;
                    const timerText = document.getElementById('timer-text');
                    if (timerText) {
                        timerText.textContent = String(minutes).padStart(2, '0') + ':' + String(seconds).padStart(2, '0');
                    }
                    
                    // Ubah warna timer saat sisa 10 detik
                    if (timeLeft <= 10) {
                        const timerDiv = document.getElementById('qr-timer');
                        if (timerDiv) {
                            timerDiv.className = 'flex items-center gap-2 text-sm text-orange-500 dark:text-orange-400 mb-6';
                        }
                    }
                    
                    // Stop saat waktu habis
                    if (timeLeft <= 0) {
                        clearInterval(timerInterval);
                        clearInterval(pollingInterval);
                        
                        // Show overlay with refresh button only
                        const qrContainer = document.getElementById('qr-container');
                        if (qrContainer) {
                            qrContainer.style.position = 'relative';
                            const overlay = document.createElement('div');
                            overlay.id = 'qr-overlay';
                            overlay.className = 'absolute inset-0 flex items-center justify-center bg-white/90 dark:bg-gray-800/90 backdrop-blur-sm rounded-xl cursor-pointer transition-all hover:bg-white/95 dark:hover:bg-gray-800/95';
                            overlay.onclick = function() { refreshQRCode(); };
                            overlay.innerHTML = '<div class="flex items-center gap-2 text-primary"><span class="material-icons-round">refresh</span><span class="font-medium">Refresh</span></div>';
                            qrContainer.appendChild(overlay);
                        }
                        
                        // Update timer text
                        const timerText = document.getElementById('timer-text');
                        if (timerText) {
                            timerText.textContent = 'QR Code Expired';
                        }
                    }
                }, 1000);
                
                // Polling untuk cek status authentication setiap 5 detik
                const pollingInterval = setInterval(function() {
                    checkAuthStatus(execId);
                }, 5000);
                
                // Simpan interval ID untuk dibersihkan saat modal ditutup
                window.qrPollingInterval = pollingInterval;
                window.qrTimerInterval = timerInterval;
            }

            function checkAuthStatus(execId) {
                // Gunakan hidden iframe untuk check status tanpa mengganggu modal
                const iframe = document.createElement('iframe');
                iframe.style.display = 'none';
                iframe.name = 'qr-status-check-' + Date.now();
                document.body.appendChild(iframe);
                
                // Buat form untuk submit ke iframe
                const checkForm = document.createElement('form');
                checkForm.method = 'POST';
                checkForm.action = '${url.loginAction}';
                checkForm.target = iframe.name;
                checkForm.style.display = 'none';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'authenticationExecution';
                input.value = execId;
                checkForm.appendChild(input);
                
                document.body.appendChild(checkForm);
                
                // Listen untuk iframe load
                iframe.onload = function() {
                    try {
                        // Check jika iframe redirect ke halaman selain login
                        const iframeUrl = iframe.contentWindow.location.href;
                        if (iframeUrl && !iframeUrl.includes('qr-login') && !iframeUrl.includes('login-actions')) {
                            // Auth berhasil, redirect halaman utama
                            window.location.href = iframeUrl;
                        }
                    } catch (e) {
                        // Cross-origin error berarti sudah redirect ke domain lain (sukses)
                        // Atau masih di halaman yang sama
                        console.log('Status check completed');
                    }
                    
                    // Cleanup
                    setTimeout(function() {
                        if (iframe.parentNode) iframe.parentNode.removeChild(iframe);
                        if (checkForm.parentNode) checkForm.parentNode.removeChild(checkForm);
                    }, 100);
                };
                
                checkForm.submit();
            }

            function refreshQRCode() {
                // Tampilkan loading state
                const qrContainer = document.getElementById('qr-container');
                const qrImage = qrContainer ? qrContainer.querySelector('img') : null;
                const overlay = document.getElementById('qr-overlay');
                
                if (overlay) {
                    overlay.innerHTML = '<div class="flex items-center gap-2 text-primary"><span class="material-icons-round animate-spin">refresh</span><span class="font-medium">Loading...</span></div>';
                }
                
                // Fetch halaman untuk mendapatkan QR baru menggunakan iframe
                const iframe = document.createElement('iframe');
                iframe.style.display = 'none';
                iframe.name = 'qr-refresh-frame-' + Date.now();
                document.body.appendChild(iframe);
                
                iframe.onload = function() {
                    try {
                        const iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
                        const newQrData = iframeDoc.getElementById('qr-auth-data');
                        
                        if (newQrData) {
                            const newQrImage = newQrData.getAttribute('data-qr-image');
                            const newTabId = newQrData.getAttribute('data-tab-id');
                            const newExecId = newQrData.getAttribute('data-qr-exec-id');
                            
                            if (newQrImage && qrImage) {
                                // Update QR image
                                qrImage.src = 'data:image/png;base64,' + newQrImage;
                                
                                // Update session text
                                const sessionText = document.querySelector('#qrModal p b');
                                if (sessionText) {
                                    sessionText.parentElement.innerHTML = '<b>Session:</b> ' + (newTabId || 'N/A');
                                }
                                
                                // Update hidden form
                                const execInput = document.querySelector('#qr-submit-form input[name="authenticationExecution"]');
                                if (execInput && newExecId) {
                                    execInput.value = newExecId;
                                }
                                
                                // Update data di qr-auth-data utama
                                const mainQrData = document.getElementById('qr-auth-data');
                                if (mainQrData) {
                                    mainQrData.setAttribute('data-qr-image', newQrImage);
                                    mainQrData.setAttribute('data-tab-id', newTabId || '');
                                    mainQrData.setAttribute('data-qr-exec-id', newExecId || '');
                                }
                                
                                // Remove overlay
                                if (overlay) {
                                    overlay.remove();
                                }
                                
                                // Reset timer
                                resetQRTimer(newExecId);
                            }
                        } else {
                            // Fallback ke reload jika gagal parse
                            window.location.reload();
                        }
                    } catch (e) {
                        console.error('QR refresh error:', e);
                        // Fallback ke reload dengan parameter
                        window.location.href = window.location.href + (window.location.href.includes('?') ? '&' : '?') + 'openQR=1';
                    }
                    
                    // Cleanup iframe
                    setTimeout(function() {
                        if (iframe.parentNode) iframe.parentNode.removeChild(iframe);
                    }, 100);
                };
                
                // Load halaman login ke iframe
                iframe.src = window.location.href;
            }
            
            function resetQRTimer(execId) {
                // Clear existing intervals
                if (window.qrPollingInterval) {
                    clearInterval(window.qrPollingInterval);
                }
                if (window.qrTimerInterval) {
                    clearInterval(window.qrTimerInterval);
                }
                
                // Reset timer display
                const timerText = document.getElementById('timer-text');
                const timerDiv = document.getElementById('qr-timer');
                if (timerText) {
                    timerText.textContent = '01:00';
                }
                if (timerDiv) {
                    timerDiv.className = 'flex items-center gap-2 text-sm text-gray-400 dark:text-gray-500 mb-6';
                }
                
                // Start new polling
                startQRPolling(execId);
            }

            function refreshQRInModal(execId) {
                // Tidak digunakan lagi, pakai refreshQRCode() untuk full reload
                console.log('QR refresh via reload');
            }

            function closeQRModal() {
                // Clear polling intervals
                if (window.qrPollingInterval) {
                    clearInterval(window.qrPollingInterval);
                    window.qrPollingInterval = null;
                }
                if (window.qrTimerInterval) {
                    clearInterval(window.qrTimerInterval);
                    window.qrTimerInterval = null;
                }
                const modal = document.getElementById('qrModal');
                if (modal) {
                    modal.remove();
                    document.body.style.overflow = '';
                }
            }
            
            // Auto open modal jika ada parameter openQR
            document.addEventListener('DOMContentLoaded', function() {
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.get('openQR') === '1') {
                    // Hapus parameter dari URL tanpa reload
                    const newUrl = window.location.href.replace(/[?&]openQR=1/, '').replace(/\?$/, '');
                    window.history.replaceState({}, document.title, newUrl);
                    // Buka modal
                    setTimeout(function() {
                        showQRModal();
                    }, 300);
                }
            });
        </script>

        <style>
            @keyframes float {
                0%, 100% { transform: translateY(0) scale(1); }
                50% { transform: translateY(-8px) scale(1.02); }
            }
            .qr-float { animation: float 3s ease-in-out infinite; }

            @keyframes glow-pulse {
                0%, 100% { box-shadow: 0 8px 32px rgba(74, 28, 111, 0.2); }
                50% { box-shadow: 0 12px 48px rgba(74, 28, 111, 0.4); }
            }
            .glow-pulse { animation: glow-pulse 2s ease-in-out infinite; }
        </style>
    </#if>
</@layout.registrationLayout>