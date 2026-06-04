<!-- GSAP skeletons adapted from taste-skill (MIT) — see CREDITS.md. -->

# Scroll-driven patterns

Canonical skeletons for scroll-driven motion, in three flavors:

1. **GSAP + ScrollTrigger** — for pin/scrub work (sticky-stack, horizontal-pan).
2. **No library** — IntersectionObserver and CSS `animation-timeline: view()` for reveals.
3. **Vue** — `<Transition>` with `position: absolute` on the leaving element for simultaneous swaps.

Hard rule across all of them: never `window.addEventListener('scroll', ...)`. It runs every frame, jank-prone, no batching. Use ScrollTrigger, IntersectionObserver, or CSS scroll-driven animations. Every GSAP block uses `gsap.context().revert()` for cleanup and bails out under reduced motion.

---

## 1. GSAP + ScrollTrigger

### 1.A Sticky-stack

Cards that pin at the top of the viewport and physically stack as the next one arrives. Common failure: trigger fires halfway through scroll instead of pinning at the top — fix with `start: "top top"`, not `"top center"` or `"top 80%"`.

```tsx
"use client";
import { useRef, useEffect } from "react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { useReducedMotion } from "motion/react";

gsap.registerPlugin(ScrollTrigger);

export function StickyStack({ cards }: { cards: React.ReactNode[] }) {
  const ref = useRef<HTMLDivElement>(null);
  const reduce = useReducedMotion();

  useEffect(() => {
    if (reduce || !ref.current) return;
    const ctx = gsap.context(() => {
      const cardEls = gsap.utils.toArray<HTMLElement>(".stack-card");
      cardEls.forEach((card, i) => {
        if (i === cardEls.length - 1) return;
        ScrollTrigger.create({
          trigger: card,
          start: "top top",                              // pin at viewport top
          endTrigger: cardEls[cardEls.length - 1],
          end: "top top",
          pin: true,
          pinSpacing: false,
        });
        gsap.to(card, {
          scale: 0.92,
          opacity: 0.55,
          ease: "none",
          scrollTrigger: {
            trigger: cardEls[i + 1],
            start: "top bottom",
            end: "top top",
            scrub: true,
          },
        });
      });
    }, ref);
    return () => ctx.revert();
  }, [reduce]);

  return (
    <div ref={ref} className="relative">
      {cards.map((card, i) => (
        <div
          key={i}
          className="stack-card sticky top-0 min-h-[100dvh] flex items-center justify-center"
        >
          {card}
        </div>
      ))}
    </div>
  );
}
```

Critical points: `start: "top top"`, `pin: true`, every card except the last is pinned, and the scale/opacity transform is driven by the **next** card's scroll trigger so the previous card shrinks as the next one arrives.

### 1.B Horizontal-pan

Vertical scroll drives a horizontal pan across a pinned section. Common failure: the animation starts before the section is pinned, so the user sees half a slide. Same fix: `start: "top top"`, pin the wrapper, scrub the inner track.

```tsx
"use client";
import { useRef, useEffect } from "react";
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { useReducedMotion } from "motion/react";

gsap.registerPlugin(ScrollTrigger);

export function HorizontalPan({ children }: { children: React.ReactNode }) {
  const wrap = useRef<HTMLDivElement>(null);
  const track = useRef<HTMLDivElement>(null);
  const reduce = useReducedMotion();

  useEffect(() => {
    if (reduce || !wrap.current || !track.current) return;
    const ctx = gsap.context(() => {
      const distance = track.current!.scrollWidth - window.innerWidth;
      gsap.to(track.current, {
        x: -distance,
        ease: "none",
        scrollTrigger: {
          trigger: wrap.current,
          start: "top top",                              // pin when section top hits viewport top
          end: () => `+=${distance}`,                    // scroll length = track width minus viewport
          pin: true,
          scrub: 1,
          invalidateOnRefresh: true,
        },
      });
    }, wrap);
    return () => ctx.revert();
  }, [reduce]);

  return (
    <section ref={wrap} className="relative overflow-hidden">
      <div ref={track} className="flex h-[100dvh] items-center">
        {children}
      </div>
    </section>
  );
}
```

Critical points: `start: "top top"`, `pin: true`, `end: "+=${distance}"` (scroll length equals the horizontal travel needed), `scrub: 1`.

### 1.C Scroll-reveal stagger (lighter alternative)

For "items appear as they enter the viewport" with no pinning, prefer Motion's `whileInView` over GSAP — lighter, no ScrollTrigger needed. Reduced motion disables the initial offset so items render in place.

```tsx
"use client";
import { motion, useReducedMotion } from "motion/react";

export function RevealStagger({ items }: { items: string[] }) {
  const reduce = useReducedMotion();
  return (
    <ul className="grid gap-6">
      {items.map((item, i) => (
        <motion.li
          key={item}
          initial={reduce ? false : { opacity: 0, y: 24 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true, amount: 0.3 }}
          transition={{
            duration: 0.6,
            delay: i * 0.06,
            ease: [0.16, 1, 0.3, 1],
          }}
        >
          {item}
        </motion.li>
      ))}
    </ul>
  );
}
```

Use this for feature lists, testimonial grids, logo walls — anything that just needs "enter on scroll". Save GSAP for actual pin/scrub work.

---

## 2. No library

### 2.A IntersectionObserver reveal

Zero dependencies, works anywhere. The observer toggles a class when the element enters the viewport; the CSS transition does the motion, gated behind `prefers-reduced-motion`.

```js
const items = document.querySelectorAll('.reveal')

const io = new IntersectionObserver((entries) => {
  entries.forEach((entry) => {
    if (!entry.isIntersecting) return
    entry.target.classList.add('is-visible')
    io.unobserve(entry.target)              // reveal once
  })
}, { threshold: 0.3 })

items.forEach((el, i) => {
  el.style.setProperty('--i', String(i))    // stagger index
  io.observe(el)
})
```

```css
.reveal {
  opacity: 0;
  transform: translateY(24px);
}
.reveal.is-visible {
  opacity: 1;
  transform: translateY(0);
  transition: opacity 0.6s, transform 0.6s;
  transition-delay: calc(var(--i) * 60ms);
}

@media (prefers-reduced-motion: reduce) {
  .reveal {
    opacity: 1;
    transform: none;
    transition: none;
  }
}
```

### 2.B CSS `animation-timeline: view()`

When browser support allows, the cleanest reveal needs no JS at all. The animation progresses as the element scrolls through the viewport. Wrap in `@media (prefers-reduced-motion: no-preference)` so reduced-motion users get the static end state.

```css
@media (prefers-reduced-motion: no-preference) {
  @keyframes reveal {
    from { opacity: 0; transform: translateY(24px); }
    to   { opacity: 1; transform: translateY(0); }
  }
  .reveal {
    animation: reveal linear both;
    animation-timeline: view();
    animation-range: entry 0% entry 40%;     // play during the first 40% of entry
  }
}
```

Outside `no-preference` the keyframes never apply, so the element keeps its natural (final) state. Treat `animation-timeline` as progressive enhancement; pair with the IntersectionObserver fallback for older browsers.

---

## 3. Vue

### 3.A Simultaneous swap with `<Transition>`

For visual swaps (icon, label) the leaving and entering elements should cross-fade in place, not play out then in. Do **not** use `mode="out-in"` for this — it serializes the two and adds a gap. Instead, take the leaving element out of flow with `position: absolute` so both occupy the same spot and transition simultaneously.

```vue
<script setup lang="ts">
const expanded = ref(false)
</script>

<template>
  <button class="toggle" @click="expanded = !expanded">
    <span class="swap">
      <Transition name="swap">
        <IconChevron v-if="!expanded" key="closed" />
        <IconChevronUp v-else key="open" />
      </Transition>
    </span>
  </button>
</template>

<style scoped>
.swap {
  position: relative;
  display: inline-flex;
}

.swap-enter-active,
.swap-leave-active {
  transition: opacity 0.18s ease, transform 0.18s ease;
}

.swap-leave-active {
  position: absolute;
  inset: 0;
}

.swap-enter-from,
.swap-leave-to {
  opacity: 0;
  transform: scale(0.85);
}

@media (prefers-reduced-motion: reduce) {
  .swap-enter-active,
  .swap-leave-active {
    transition: none;
  }
}
</style>
```

The leaving element is pulled out of flow with `position: absolute` so it overlaps the entering one during the transition; both fade and scale together. No layout jump, no `mode="out-in"` delay.
