<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true; section>
    <#if section = "title">
        ${msg("consentDenied")}
    <#elseif section = "header">
        ${msg("consentDenied")}
    <#elseif section = "form">
        <div class="flex flex-col items-center justify-center pt-8 pb-6">
            <div class="relative mb-0 flex items-center justify-center" style="width: 300px; height: 250px;">
                <!-- Floating particles -->
                <div class="floating-dot-cancel" style="top: 5%; left: 8%;"></div>
                <div class="floating-dot-cancel" style="top: 15%; right: 10%; animation-delay: 1s;"></div>
                <div class="floating-dot-cancel small" style="bottom: 20%; right: 15%; animation-delay: 2s;"></div>
                
                <!-- Glow breathing effect -->
                <div class="glow-layer-cancel"></div>
                
                <!-- Main cancel icon -->
                <div class="cancel-icon">
                    <span class="material-icons-round text-white" style="font-size: 48px;">close</span>
                </div>
            </div>
            
            <h1 class="text-3xl font-bold mb-3 text-gray-900 dark:text-white text-center">
                ${msg("consentDenied")}
            </h1>
            
            <p class="text-gray-500 dark:text-gray-400 text-center max-w-md mb-6">
                Login dengan QR Code telah dibatalkan.
            </p>

            <a href="${url.loginUrl}" 
                class="inline-flex items-center py-2.5 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-primary hover:bg-opacity-90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary transition-colors">
                <span class="material-icons-round mr-2">arrow_back</span>
                Kembali ke Login
            </a>
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

            @keyframes breathe-glow-cancel {
                0%, 100% {
                    transform: translate(-50%, -50%) scale(1);
                    box-shadow: 0 0 40px rgba(220, 38, 38, 0.3),
                                0 0 80px rgba(220, 38, 38, 0.2),
                                0 0 120px rgba(220, 38, 38, 0.1);
                }
                50% {
                    transform: translate(-50%, -50%) scale(1.2);
                    box-shadow: 0 0 60px rgba(220, 38, 38, 0.5),
                                0 0 100px rgba(220, 38, 38, 0.3),
                                0 0 140px rgba(220, 38, 38, 0.2);
                }
            }

            .glow-layer-cancel {
                position: absolute;
                top: 50%;
                left: 50%;
                width: 70px;
                height: 70px;
                border-radius: 50%;
                background: radial-gradient(circle, rgba(220, 38, 38, 0.15) 0%, rgba(220, 38, 38, 0.05) 50%, transparent 100%);
                animation: breathe-glow-cancel 4s ease-in-out infinite;
            }

            .cancel-icon {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 90px;
                height: 90px;
                background: #dc2626;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 
                    0 8px 30px rgba(220, 38, 38, 0.4),
                    0 0 0 6px rgba(220, 38, 38, 0.15);
                z-index: 10;
                animation: scale-in 1s cubic-bezier(0.34, 1.56, 0.64, 1) forwards;
            }

            .floating-dot-cancel {
                position: absolute;
                width: 12px;
                height: 12px;
                background: #dc2626;
                border-radius: 50%;
                animation: float 6s ease-in-out infinite;
                opacity: 0.7;
            }

            .floating-dot-cancel:nth-child(1) { animation-delay: 0s; }
            .floating-dot-cancel:nth-child(2) { animation-delay: 1.3s; }
            .floating-dot-cancel:nth-child(3) { animation-delay: 2.6s; }

            .floating-dot-cancel.small {
                width: 8px;
                height: 8px;
            }

            .dark .glow-layer-cancel {
                background: radial-gradient(circle, rgba(248, 113, 113, 0.15) 0%, rgba(248, 113, 113, 0.05) 50%, transparent 100%);
            }

            .dark .cancel-icon {
                background: #dc2626;
                box-shadow: 
                    0 8px 30px rgba(220, 38, 38, 0.4),
                    0 0 0 6px rgba(220, 38, 38, 0.15);
            }

            .dark .floating-dot-cancel {
                background: #f87171;
            }
        </style>
    </#if>
</@layout.registrationLayout>