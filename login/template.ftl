<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>${msg("loginTitle")}</title>
    <script src="https://cdn.tailwindcss.com?plugins=forms,typography"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet" />
    <script>
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        primary: "#4A1C6F",
                        accent: "#D4AF37",
                        cream: "#F5F5DC",
                        "background-light": "#FFFFFF",
                        "background-dark": "#0F172A",
                        "surface-light": "#F8FAFC",
                        "surface-dark": "#1E293B",
                    },
                    fontFamily: {
                        display: ["Inter", "sans-serif"],
                        sans: ["Inter", "sans-serif"],
                    },
                    borderRadius: {
                        DEFAULT: "0.5rem",
                    },
                },
            },
        };
    </script>
    <style>
        .mesh-gradient {
            background-color: #4A1C6F;
            background-image:
                radial-gradient(at 80% 0%, hsla(46, 71%, 52%, 1) 0px, transparent 50%),
                radial-gradient(at 0% 50%, hsla(273, 60%, 37%, 1) 0px, transparent 50%),
                radial-gradient(at 80% 50%, hsla(50, 100%, 94%, 1) 0px, transparent 50%),
                radial-gradient(at 0% 100%, hsla(273, 60%, 37%, 1) 0px, transparent 50%),
                radial-gradient(at 80% 100%, hsla(46, 71%, 52%, 1) 0px, transparent 50%),
                radial-gradient(at 0% 0%, hsla(50, 100%, 94%, 1) 0px, transparent 50%);
            filter: blur(60px);
        }

        /* Insight Slider Styles */
        .insight-slider {
            position: relative;
            min-height: 280px;
        }

        .insight-slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            opacity: 0;
            transform: translateX(30px);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            pointer-events: none;
        }

        .insight-slide.active {
            position: relative;
            opacity: 1;
            transform: translateX(0);
            pointer-events: auto;
        }

        .insight-slide.slide-out-left {
            opacity: 0;
            transform: translateX(-30px);
        }

        .insight-slide.slide-out-right {
            opacity: 0;
            transform: translateX(30px);
        }

        /* Slider Progress Dots */
        .slider-dot-wrapper {
            position: relative;
            width: 24px;
            height: 4px;
            border-radius: 4px;
            overflow: hidden;
            transition: width 0.3s ease;
        }

        .slider-dot-wrapper.active {
            width: 48px;
        }

        .slider-dot-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(74, 28, 111, 0.2);
            border-radius: 4px;
        }

        .slider-dot-wrapper:hover .slider-dot-bg {
            background-color: rgba(74, 28, 111, 0.3);
        }

        .slider-dot-progress {
            position: absolute;
            top: 0;
            left: 0;
            width: 0%;
            height: 100%;
            background: linear-gradient(90deg, #4A1C6F 0%, #7B3FA0 100%);
            border-radius: 4px;
            transition: width 0.1s linear;
        }

        .slider-dot-wrapper.active .slider-dot-progress {
            animation: progressFill 5s linear forwards;
        }

        .slider-dot-wrapper.completed .slider-dot-progress {
            width: 100%;
            animation: none;
        }

        @keyframes progressFill {
            from { width: 0%; }
            to { width: 100%; }
        }

        /* Orbiting Gradient Blobs */
        .blob-orbit-1 {
            animation: orbitBlob1 30s ease-in-out infinite;
        }

        .blob-orbit-2 {
            animation: orbitBlob2 35s ease-in-out infinite;
        }

        .blob-orbit-3 {
            animation: orbitBlob3 40s ease-in-out infinite;
        }

        @keyframes orbitBlob1 {
            0% { transform: translate(0, 0) scale(1); }
            10% { transform: translate(25%, -10%) scale(1.15); }
            20% { transform: translate(-5%, 30%) scale(0.9); }
            35% { transform: translate(35%, 15%) scale(1.05); }
            45% { transform: translate(-20%, -20%) scale(1.2); }
            60% { transform: translate(10%, 35%) scale(0.85); }
            75% { transform: translate(-30%, 5%) scale(1.1); }
            85% { transform: translate(20%, -25%) scale(0.95); }
            100% { transform: translate(0, 0) scale(1); }
        }

        @keyframes orbitBlob2 {
            0% { transform: translate(0, 0) scale(1); }
            12% { transform: translate(-30%, 20%) scale(1.1); }
            25% { transform: translate(15%, -30%) scale(0.85); }
            38% { transform: translate(-10%, 10%) scale(1.2); }
            50% { transform: translate(30%, 25%) scale(0.9); }
            65% { transform: translate(-25%, -15%) scale(1.15); }
            78% { transform: translate(20%, 5%) scale(0.95); }
            90% { transform: translate(-15%, 30%) scale(1.05); }
            100% { transform: translate(0, 0) scale(1); }
        }

        @keyframes orbitBlob3 {
            0% { transform: translate(0, 0) scale(1); }
            15% { transform: translate(20%, 25%) scale(1.15); }
            28% { transform: translate(-35%, -10%) scale(0.9); }
            42% { transform: translate(10%, -30%) scale(1.1); }
            55% { transform: translate(-20%, 20%) scale(0.85); }
            70% { transform: translate(30%, -5%) scale(1.2); }
            82% { transform: translate(-10%, 15%) scale(0.95); }
            100% { transform: translate(0, 0) scale(1); }
        }

        /* Hide global scrollbar */
        html, body {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        html::-webkit-scrollbar,
        body::-webkit-scrollbar {
            display: none;
        }
    </style>
</head>

<body class="font-sans antialiased bg-background-light dark:bg-background-dark text-gray-900 dark:text-gray-100 transition-colors duration-300">
    <div class="flex min-h-screen w-full overflow-hidden">
        <!-- Panel Kiri: Form -->
        <div class="w-full min-[1220px]:w-[45%] flex flex-col justify-between p-8 sm:p-12 min-[1220px]:p-16 2xl:p-12 bg-background-light dark:bg-background-dark z-10 relative">
            <!-- Logo Header -->
            <div class="flex items-center gap-3">
                <img alt="" class="h-12 w-auto object-contain"
                    src="${url.resourcesPath}/img/logo-pemda-diy.png" 
                    onerror="this.src='https://jogjaprov.go.id/storage/files/shares/page/1518066730_2d84b769e3cc9d6f06f8c91a6c3e285c.jpg'" />
                <div class="flex flex-col">
                    <span class="text-xs font-bold tracking-widest uppercase text-gray-500 dark:text-gray-400">PEMDA DIY</span>
                    <span class="text-xs font-semibold text-primary dark:text-accent">Yogyakarta</span>
                </div>
            </div>

            <!-- Konten Utama -->
            <div class="flex flex-col justify-center max-w-md w-full mx-auto mt-10 lg:mt-10">
                <#nested "form">
            </div>

            <!-- Footer -->
            <div class="mt-8 text-center min-[1220px]:text-left">
                <#nested "footer">
            </div>
        </div>

        <!-- Panel Kanan: BG Hiasan -->
        <div class="hidden min-[1220px]:block min-[1220px]:w-[55%] bg-white dark:bg-gray-900"></div>

        <!-- Fixed content that stays centered -->
        <div class="hidden min-[1220px]:block fixed top-0 right-0 w-[55%] h-screen overflow-hidden bg-white dark:bg-gray-900 z-0">
            <div class="absolute inset-0">
                <div class="absolute -top-[10%] -right-[10%] w-[80%] h-[80%] rounded-full mix-blend-multiply filter blur-3xl opacity-50 bg-[#8B5CF6] blob-orbit-1"></div>
                <div class="absolute top-[30%] right-[20%] w-[60%] h-[60%] rounded-full mix-blend-multiply filter blur-3xl opacity-60 bg-[#D4AF37] blob-orbit-2"></div>
                <div class="absolute -bottom-[10%] left-[10%] w-[70%] h-[70%] rounded-full mix-blend-multiply filter blur-3xl opacity-50 bg-[#F5F5DC] blob-orbit-3"></div>
            </div>
            <div class="absolute inset-0 bg-white/10 dark:bg-black/10 backdrop-blur-[1px]"></div>
            <div class="absolute inset-0 flex flex-col justify-center px-16 xl:px-24 z-20">
                <div class="max-w-xl">
                    <#nested "info">
                </div>
            </div>
        </div>
    </div>

    <script>
        // Toggle password visibility
        function togglePasswordVisibility(inputId, button) {
            const input = document.getElementById(inputId);
            const icon = button.querySelector('.material-icons-round');
            if (input.type === 'password') {
                input.type = 'text';
                icon.textContent = 'visibility';
            } else {
                input.type = 'password';
                icon.textContent = 'visibility_off';
            }
        }

        // Insight Slider Functionality
        document.addEventListener('DOMContentLoaded', function() {
            const slides = document.querySelectorAll('.insight-slide');
            const dots = document.querySelectorAll('.slider-dot-wrapper');
            const prevBtn = document.getElementById('sliderPrev');
            const nextBtn = document.getElementById('sliderNext');
            
            if (slides.length === 0) return;
            
            let currentSlide = 0;
            let autoSlideInterval;
            const totalSlides = slides.length;
            const slideDuration = 5000;

            function resetProgressAnimation(dotWrapper) {
                if (!dotWrapper) return;
                const progress = dotWrapper.querySelector('.slider-dot-progress');
                if (progress) {
                    progress.style.animation = 'none';
                    progress.offsetHeight;
                    progress.style.animation = '';
                }
            }

            function goToSlide(index, direction = 'next') {
                if (index < 0) index = totalSlides - 1;
                if (index >= totalSlides) index = 0;
                
                const currentSlideEl = slides[currentSlide];
                const nextSlideEl = slides[index];
                
                if (direction === 'next') {
                    currentSlideEl.classList.add('slide-out-left');
                } else {
                    currentSlideEl.classList.add('slide-out-right');
                }
                
                if (dots[currentSlide]) {
                    dots[currentSlide].classList.remove('active');
                    if (direction === 'next' && index > currentSlide) {
                        dots[currentSlide].classList.add('completed');
                    } else {
                        dots.forEach((dot, i) => {
                            if (i >= index) {
                                dot.classList.remove('completed');
                            } else {
                                dot.classList.add('completed');
                            }
                        });
                    }
                }
                
                currentSlideEl.classList.remove('active');
                
                setTimeout(() => {
                    currentSlideEl.classList.remove('slide-out-left', 'slide-out-right');
                    nextSlideEl.classList.add('active');
                    if (dots[index]) {
                        dots[index].classList.add('active');
                        resetProgressAnimation(dots[index]);
                    }
                    currentSlide = index;
                }, 100);
            }

            function nextSlide() { goToSlide(currentSlide + 1, 'next'); }
            function prevSlide() { goToSlide(currentSlide - 1, 'prev'); }
            function startAutoSlide() { autoSlideInterval = setInterval(nextSlide, slideDuration); }
            function resetAutoSlide() { 
                clearInterval(autoSlideInterval); 
                resetProgressAnimation(dots[currentSlide]); 
                startAutoSlide(); 
            }

            if (prevBtn) { prevBtn.addEventListener('click', () => { prevSlide(); resetAutoSlide(); }); }
            if (nextBtn) { nextBtn.addEventListener('click', () => { nextSlide(); resetAutoSlide(); }); }
            
            dots.forEach((dot, index) => {
                dot.addEventListener('click', () => {
                    if (index !== currentSlide) {
                        const direction = index > currentSlide ? 'next' : 'prev';
                        goToSlide(index, direction);
                        resetAutoSlide();
                    }
                });
            });
            
            if (dots[0]) resetProgressAnimation(dots[0]);
            startAutoSlide();
        });
    </script>
    
    <#nested "script">
</body>
</html>
</#macro>
