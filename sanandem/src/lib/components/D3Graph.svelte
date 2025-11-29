<script lang="ts">
    import { onMount } from 'svelte';
    import * as d3 from 'd3';

    let svg: SVGSVGElement;
    let width = 600;
    let height = 400;

    onMount(() => {
        const nodes = Array.from({ length: 20 }, (_, i) => ({ id: i, group: Math.floor(Math.random() * 3) }));
        const links = Array.from({ length: 30 }, () => ({
            source: Math.floor(Math.random() * 20),
            target: Math.floor(Math.random() * 20),
            value: Math.random()
        }));

        // @ts-ignore
        const simulation = d3.forceSimulation(nodes)
             // @ts-ignore
            .force("link", d3.forceLink(links).id((d: any) => d.id))
            .force("charge", d3.forceManyBody().strength(-100))
            .force("center", d3.forceCenter(width / 2, height / 2));

        const svgEl = d3.select(svg);
        svgEl.selectAll("*").remove(); // Clear previous

        const link = svgEl.append("g")
            .attr("stroke", "#94a3b8")
            .attr("stroke-opacity", 0.6)
            .selectAll("line")
            .data(links)
            .join("line")
             // @ts-ignore
            .attr("stroke-width", d => Math.sqrt(d.value));

        const node = svgEl.append("g")
            .attr("stroke", "#1e293b")
            .attr("stroke-width", 1.5)
            .selectAll("circle")
            .data(nodes)
            .join("circle")
            .attr("r", 8)
             // @ts-ignore
            .attr("fill", d => d3.schemeTableau10[d.group]);

        node.append("title")
             // @ts-ignore
            .text(d => d.id);

        simulation.on("tick", () => {
            link
                .attr("x1", (d: any) => d.source.x)
                .attr("y1", (d: any) => d.source.y)
                .attr("x2", (d: any) => d.target.x)
                .attr("y2", (d: any) => d.target.y);

            node
                .attr("cx", (d: any) => d.x)
                .attr("cy", (d: any) => d.y);
        });

        return () => {
            simulation.stop();
        };
    });
</script>

<div class="w-full h-full flex items-center justify-center bg-slate-900/50 rounded-xl border border-slate-800">
    <svg bind:this={svg} {width} {height} viewBox="0 0 {width} {height}" class="max-w-full max-h-full"></svg>
</div>
