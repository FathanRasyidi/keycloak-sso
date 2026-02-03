<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("successQrCodeLoginTitle")}
    <#elseif section = "header">
        ${msg("successQrCodeLoginTitle")}
    <#elseif section = "form">
        <div class="flex flex-col items-center justify-center pt-8 pb-6">
            <div class="relative mb-0 flex items-center justify-center" style="width: 300px; height: 250px;">
                <!-- Floating particles -->
                <div class="floating-dot" style="top: 5%; left: 8%;"></div>
                <div class="floating-dot" style="top: 15%; right: 10%; animation-delay: 1s;"></div>
                <div class="floating-dot small" style="bottom: 20%; right: 15%; animation-delay: 2s;"></div>
                
                <!-- Glow breathing effect -->
                <div class="glow-layer"></div>
                
                <!-- Main success icon -->
                <div class="success-icon">
                    <span class="material-icons-round text-white" style="font-size: 48px;">check</span>
                </div>
            </div>
            
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white text-center">
                ${msg("successQrCodeLoginTitle")}
            </h1>
            
            <p class="text-gray-500 dark:text-gray-400 text-center max-w-md">
                ${msg("successQrCodeLoginMessage")}
            </p>
        </div>

        <style>
            @keyframes pulse {
                0%, 100% {
                    transform: translate(-50%, -50%) scale(1);
                    opacity: 1;
                }
                50% {
                    transform: translate(-50%, -50%) scale(1.05);
                    opacity: 0.8;
                }
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                    opacity: 0.7;
                }
                50% {
                    transform: translateY(-20px);
                    opacity: 1;
                }
            }

            @keyframes scale-in {
                0% {
                    transform: translate(-50%, -50%) scale(0);
                    opacity: 0;
                }
                50% {
                    transform: translate(-50%, -50%) scale(1.1);
                }
                100% {
                    transform: translate(-50%, -50%) scale(1);
                    opacity: 1;
                }
            }

            @keyframes breathe-glow {
                0%, 100% {
                    transform: translate(-50%, -50%) scale(1);
                    box-shadow: 0 0 40px rgba(16, 185, 129, 0.3),
                                0 0 80px rgba(16, 185, 129, 0.2),
                                0 0 120px rgba(16, 185, 129, 0.1);
                }
                50% {
                    transform: translate(-50%, -50%) scale(1.2);
                    box-shadow: 0 0 60px rgba(16, 185, 129, 0.5),
                                0 0 100px rgba(16, 185, 129, 0.3),
                                0 0 140px rgba(16, 185, 129, 0.2);
                }
            }

            @keyframes fade-in-up {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .glow-layer {
                position: absolute;
                top: 50%;
                left: 50%;
                width: 70px;
                height: 70px;
                border-radius: 50%;
                background: radial-gradient(circle, rgba(16, 185, 129, 0.15) 0%, rgba(16, 185, 129, 0.05) 50%, transparent 100%);
                animation: breathe-glow 4s ease-in-out infinite;
            }

            .success-icon {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 90px;
                height: 90px;
                background: #10b981;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 
                    0 8px 30px rgba(16, 185, 129, 0.4),
                    0 0 0 6px rgba(16, 185, 129, 0.15);
                z-index: 10;
                animation: scale-in 1s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
            }

            .floating-dot {
                position: absolute;
                width: 12px;
                height: 12px;
                background: #10b981;
                border-radius: 50%;
                animation: float 6s ease-in-out infinite;
                opacity: 0.7;
            }

            .floating-dot:nth-child(1) { animation-delay: 0s; }
            .floating-dot:nth-child(2) { animation-delay: 1.3s; }
            .floating-dot:nth-child(3) { animation-delay: 2.6s; }

            .floating-dot.small {
                width: 8px;
                height: 8px;
            }

            .dark .glow-layer {
                background: radial-gradient(circle, rgba(52, 211, 153, 0.15) 0%, rgba(52, 211, 153, 0.05) 50%, transparent 100%);
            }

            @keyframes breathe-glow {
                0%, 100% {
                    transform: translate(-50%, -50%) scale(1);
                    box-shadow: 0 0 40px rgba(16, 185, 129, 0.3),
                                0 0 80px rgba(16, 185, 129, 0.2),
                                0 0 120px rgba(16, 185, 129, 0.1);
                }
                50% {
                    transform: translate(-50%, -50%) scale(1.2);
                    box-shadow: 0 0 60px rgba(16, 185, 129, 0.5),
                                0 0 100px rgba(16, 185, 129, 0.3),
                                0 0 140px rgba(16, 185, 129, 0.2);
                }
            }
            }6) !important;
            }

            .dark .circle-layer:nth-child(5) {
                background: rgba(52, 211, 153, 0.1) !important;
            }

            .dark .circle-layer:nth-child(6) {
                background: rgba(52, 211, 153, 0.14

            .dark .success-icon {
                background: #10b981;
                box-shadow: 
                    0 8px 30px rgba(16, 185, 129, 0.4),
                    0 0 0 6px rgba(16, 185, 129, 0.15);
            }

            .dark .floating-dot {
                background: #34d399;
            }

            .fade-in-up {
                animation: fade-in-up 0.8s ease-out 0.6s forwards;
                opacity: 0;
            }
        </style>
    </#if>
</@layout.registrationLayout>