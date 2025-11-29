<script lang="ts">
    import { Motion } from 'svelte-motion';
    import { onMount } from 'svelte';
    // @ts-ignore
    import { Confetti } from '@neoconfetti/svelte';
    // @ts-ignore
    import AnimatedHeadline from 'svelte-animated-headline';
    import { isLowPerformanceMode } from '$lib/stores/settings';
    // @ts-ignore
    import NumberFlow from '@number-flow/svelte';
    // @ts-ignore
    import { LottiePlayer } from '@lottiefiles/svelte-lottie-player';
    import { Accordion } from 'bits-ui';

    let showConfetti = false;
    let innerWidth = 0;
    let participantCount = 120;

    function triggerConfetti() {
        showConfetti = true;
        setTimeout(() => showConfetti = false, 2000);
    }

    onMount(() => {
        // Simulate counting up
        const interval = setInterval(() => {
            participantCount += Math.floor(Math.random() * 5);
            if(participantCount > 5000) clearInterval(interval);
        }, 1500);

        return () => clearInterval(interval);
    });
</script>

<svelte:window bind:innerWidth />

<div class="relative min-h-screen bg-slate-950 text-white overflow-hidden font-sans">
    {#if showConfetti}
        <div class="absolute top-0 left-1/2 -translate-x-1/2 z-50 pointer-events-none">
             <Confetti />
        </div>
    {/if}

    <!-- Background Grid -->
    <div class="absolute inset-0 z-0 opacity-20" style="background-image: radial-gradient(#3b82f6 1px, transparent 1px); background-size: 32px 32px;"></div>

    <main class="relative z-10 flex flex-col items-center justify-center pt-32 px-4 text-center">

        <Motion initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }}>
            <div class="mb-12 flex flex-col items-center">
                 <div class="inline-flex items-center px-3 py-1 rounded-full border border-blue-500/30 bg-blue-500/10 text-blue-400 text-xs font-medium uppercase tracking-wider mb-6 backdrop-blur-sm">
                    Open Medical Research
                </div>
                <h1 class="text-5xl md:text-7xl font-extrabold tracking-tight mb-6 bg-clip-text text-transparent bg-gradient-to-b from-white to-slate-400">
                    Understanding Side Effects<br/>
                    <span class="text-blue-500">
                         <AnimatedHeadline words={['Together', 'Safely', 'Globally', 'Now']} />
                    </span>
                </h1>
                <p class="text-lg md:text-xl text-slate-400 max-w-2xl mx-auto mb-8 leading-relaxed">
                    A decentralized platform to visualize and analyze anonymous medical data.
                    Join the movement to make medication safer for everyone.
                </p>

                <div class="flex items-center gap-3 mb-10 text-blue-300 bg-slate-900/50 px-6 py-3 rounded-2xl border border-slate-800">
                    <span class="text-3xl font-bold">
                        <NumberFlow value={participantCount} />
                    </span>
                    <span class="text-sm font-medium uppercase tracking-wide opacity-80">Participants Joined</span>
                </div>

                <div class="flex flex-col sm:flex-row gap-4 justify-center items-center">
                    <button
                        on:click={triggerConfetti}
                        class="px-8 py-4 bg-blue-600 hover:bg-blue-500 text-white rounded-xl font-semibold shadow-lg shadow-blue-500/20 transition-all hover:scale-105 active:scale-95"
                    >
                        Share Your Data
                    </button>
                    <a href="/visualizations" class="px-8 py-4 bg-slate-800 hover:bg-slate-700 text-white rounded-xl font-semibold border border-slate-700 transition-all hover:bg-slate-700">
                        View Visualizations
                    </a>
                </div>
            </div>
        </Motion>

        <!-- Feature Cards / Magic Elements Placeholder -->
        <div class="mt-12 grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl w-full px-4 mb-20">
            {#each [1, 2, 3] as i}
                <Motion initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.2 * i, duration: 0.6 }}>
                    <div class="bg-slate-900/50 backdrop-blur-md border border-slate-800 p-6 rounded-2xl hover:border-blue-500/50 transition-colors group text-left">
                        <div class="h-12 w-12 bg-blue-500/20 rounded-lg flex items-center justify-center mb-4 group-hover:bg-blue-500/30 transition-colors">
                            <div class="w-6 h-6 bg-blue-500 rounded-sm"></div>
                        </div>
                        <h3 class="text-xl font-semibold mb-2">Feature {i}</h3>
                        <p class="text-slate-400">Advanced analysis using state-of-the-art algorithms and visualizations.</p>
                    </div>
                </Motion>
            {/each}
        </div>

        <!-- FAQ and Lottie -->
        <div class="max-w-5xl mx-auto w-full px-4 mb-24 grid md:grid-cols-2 gap-12 items-center text-left">
            <div>
                 <h2 class="text-3xl font-bold mb-6">Frequently Asked Questions</h2>
                 <Accordion.Root class="w-full space-y-4">
                    <Accordion.Item value="item-1" class="border border-slate-800 rounded-lg px-4 bg-slate-900/50">
                        <Accordion.Trigger class="flex w-full flex-1 items-center justify-between py-4 font-medium transition-all hover:text-blue-400 [&[data-state=open]>svg]:rotate-180">
                            Is my data anonymous?
                             <svg class="h-4 w-4 shrink-0 transition-transform duration-200" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                            </svg>
                        </Accordion.Trigger>
                        <Accordion.Content class="text-sm pb-4 text-slate-400">
                            Yes, strictly anonymous. We do not collect any PII (Personally Identifiable Information).
                        </Accordion.Content>
                    </Accordion.Item>
                     <Accordion.Item value="item-2" class="border border-slate-800 rounded-lg px-4 bg-slate-900/50">
                        <Accordion.Trigger class="flex w-full flex-1 items-center justify-between py-4 font-medium transition-all hover:text-blue-400 [&[data-state=open]>svg]:rotate-180">
                            How is the data used?
                             <svg class="h-4 w-4 shrink-0 transition-transform duration-200" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                            </svg>
                        </Accordion.Trigger>
                        <Accordion.Content class="text-sm pb-4 text-slate-400">
                            Researchers use the aggregated data to find patterns in medication side effects.
                        </Accordion.Content>
                    </Accordion.Item>
                 </Accordion.Root>
            </div>
            <div class="flex justify-center bg-slate-900/30 rounded-full p-8">
                <!-- Medical Lottie Placeholder -->
                <LottiePlayer
                    src="https://lottie.host/80401037-9759-4504-8902-610141f2249e/z5gXpX11Wc.json"
                    autoplay={true}
                    loop={true}
                    controls={false}
                    renderer="svg"
                    background="transparent"
                    height={300}
                    width={300}
                />
            </div>
        </div>

    </main>
</div>
