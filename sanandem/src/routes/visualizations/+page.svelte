<script lang="ts">
    import { onMount } from 'svelte';
    import * as echarts from 'echarts';
    import 'echarts-gl';
    // @ts-ignore
    import { isLowPerformanceMode } from '$lib/stores/settings';
    import D3Graph from '$lib/components/D3Graph.svelte';

    let chart3DDom: HTMLDivElement;

    onMount(() => {
        let myChart: echarts.ECharts;
        if (chart3DDom) {
            myChart = echarts.init(chart3DDom, 'dark');
            const hours = ['12a', '1a', '2a', '3a', '4a', '5a', '6a',
                    '7a', '8a', '9a','10a','11a',
                    '12p', '1p', '2p', '3p', '4p', '5p',
                    '6p', '7p', '8p', '9p', '10p', '11p'];
            const days = ['Saturday', 'Friday', 'Thursday',
                    'Wednesday', 'Tuesday', 'Monday', 'Sunday'];

            const data = [];
            for (let i = 0; i < days.length; i++) {
                for (let j = 0; j < hours.length; j++) {
                    data.push([j, i, Math.floor(Math.random() * 15)]);
                }
            }

            const option = {
                backgroundColor: 'transparent',
                title: { text: 'Reports Heatmap (3D)' },
                tooltip: {},
                visualMap: {
                    max: 20,
                    inRange: {
                        color: ['#313695', '#4575b4', '#74add1', '#abd9e9', '#e0f3f8', '#ffffbf', '#fee090', '#fdae61', '#f46d43', '#d73027', '#a50026']
                    }
                },
                xAxis3D: {
                    type: 'category',
                    data: hours,
                    name: 'Hour'
                },
                yAxis3D: {
                    type: 'category',
                    data: days,
                    name: 'Day'
                },
                zAxis3D: {
                    type: 'value',
                    name: 'Count'
                },
                grid3D: {
                    boxWidth: 200,
                    boxDepth: 80,
                    light: {
                        main: {
                            intensity: 1.2,
                            shadow: true
                        },
                        ambient: {
                            intensity: 0.3
                        }
                    }
                },
                series: [{
                    type: 'bar3D',
                    data: data.map(function (item) {
                        return {
                            value: [item[0], item[1], item[2]],
                        }
                    }),
                    shading: 'lambert',
                    label: {
                        show: false,
                        fontSize: 16,
                        borderWidth: 1
                    },
                    itemStyle: {
                        opacity: 0.8
                    },
                    emphasis: {
                        label: {
                            fontSize: 20,
                            color: '#900'
                        },
                        itemStyle: {
                            color: '#900'
                        }
                    }
                }]
            };
            myChart.setOption(option);

            const handleResize = () => myChart.resize();
            window.addEventListener('resize', handleResize);

            return () => {
                window.removeEventListener('resize', handleResize);
                myChart.dispose();
            };
        }
    });
</script>

<div class="min-h-screen bg-slate-950 text-white pt-24 px-4 md:px-8">
    <div class="max-w-7xl mx-auto space-y-8">
        <div class="flex justify-between items-center">
            <h1 class="text-3xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-blue-400 to-purple-600">
                Advanced Visualization
            </h1>
            <label class="flex items-center gap-2 text-sm text-slate-400 cursor-pointer">
                <span>Low Performance Mode</span>
                <input type="checkbox" bind:checked={$isLowPerformanceMode} class="w-4 h-4 rounded border-slate-700 bg-slate-800 text-blue-600 focus:ring-blue-600 focus:ring-offset-slate-900" />
            </label>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
            <!-- 3D Chart -->
            <div class="bg-slate-900/50 border border-slate-800 rounded-2xl p-6 backdrop-blur-md shadow-xl">
                 <div bind:this={chart3DDom} style="width: 100%; height: 500px;"></div>
            </div>

            <!-- D3 Graph -->
            <div class="bg-slate-900/50 border border-slate-800 rounded-2xl p-6 backdrop-blur-md shadow-xl flex flex-col">
                <h3 class="text-xl font-semibold mb-4 text-slate-200">Network Analysis</h3>
                <div class="flex-1 min-h-[400px]">
                    <D3Graph />
                </div>
            </div>
        </div>
    </div>
</div>
