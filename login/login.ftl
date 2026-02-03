<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true displayInfo=false; section>
    <#if section = "form">
        <#-- Determine redirect URL - use restart flow to get fresh QR session -->
        <#assign redirectUrl = url.loginRestartFlowUrl!url.loginUrl>
        
        <div class="flex flex-col items-center justify-center min-h-[60vh] text-center px-4">
            <#-- Error/Warning Message -->
            <#if message?has_content && (message.type == 'error' || message.type == 'warning')>
                <div class="mb-8">
                    <div class="w-20 h-20 mx-auto mb-6 rounded-full bg-red-100 dark:bg-red-900/30 flex items-center justify-center">
                        <span class="material-icons-round text-red-500 text-4xl">error_outline</span>
                    </div>
                    <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white mb-3">Login Gagal</h1>
                    <p class="text-gray-600 dark:text-gray-400 max-w-md mx-auto mb-2">${kcSanitize(message.summary)?no_esc}</p>
                </div>
            <#elseif message?has_content && message.type == 'success'>
                <div class="mb-8">
                    <div class="w-20 h-20 mx-auto mb-6 rounded-full bg-green-100 dark:bg-green-900/30 flex items-center justify-center">
                        <span class="material-icons-round text-green-500 text-4xl">check_circle_outline</span>
                    </div>
                    <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white mb-3">Berhasil</h1>
                    <p class="text-gray-600 dark:text-gray-400 max-w-md mx-auto mb-2">${kcSanitize(message.summary)?no_esc}</p>
                </div>
            <#elseif message?has_content && message.type == 'info'>
                <div class="mb-8">
                    <div class="w-20 h-20 mx-auto mb-6 rounded-full bg-blue-100 dark:bg-blue-900/30 flex items-center justify-center">
                        <span class="material-icons-round text-blue-500 text-4xl">info_outline</span>
                    </div>
                    <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white mb-3">Informasi</h1>
                    <p class="text-gray-600 dark:text-gray-400 max-w-md mx-auto mb-2">${kcSanitize(message.summary)?no_esc}</p>
                </div>
            <#else>
                <#-- No message, redirect immediately -->
                <div class="mb-8">
                    <div class="w-20 h-20 mx-auto mb-6 rounded-full bg-primary/10 flex items-center justify-center">
                        <span class="material-icons-round text-primary text-4xl animate-spin">sync</span>
                    </div>
                    <h1 class="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white mb-3">Mengalihkan...</h1>
                    <p class="text-gray-600 dark:text-gray-400 max-w-md mx-auto">Anda akan dialihkan ke halaman login</p>
                </div>
                <script>
                    // Auto redirect jika tidak ada pesan
                    setTimeout(function() {
                        window.location.href = '${redirectUrl}';
                    }, 100);
                </script>
            </#if>

            <#-- Redirect Button -->
            <a href="${redirectUrl}" 
                class="inline-flex items-center justify-center py-3 px-8 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors">
                <span class="material-icons-round mr-2">arrow_back</span>
                Kembali ke Login
            </a>

            <#-- Auto redirect after 5 seconds for error/warning -->
            <#if message?has_content && (message.type == 'error' || message.type == 'warning')>
                <p class="text-sm text-gray-400 mt-6" id="countdown-text">Mengalihkan otomatis dalam <span id="countdown">5</span> detik...</p>
                <script>
                    let countdown = 5;
                    const countdownEl = document.getElementById('countdown');
                    const countdownInterval = setInterval(function() {
                        countdown--;
                        if (countdownEl) countdownEl.textContent = countdown;
                        if (countdown <= 0) {
                            clearInterval(countdownInterval);
                            window.location.href = '${redirectUrl}';
                        }
                    }, 1000);
                </script>
            </#if>
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
    </#if>
</@layout.registrationLayout>
