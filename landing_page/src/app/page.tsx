import Image from "next/image";
import Link from "next/link";

export default function Home() {
  return (
    <div className="min-h-screen bg-slate-900 text-slate-50 font-sans selection:bg-indigo-500 selection:text-white">
      {/* Navigation */}
      <nav className="flex items-center justify-between p-6 max-w-7xl mx-auto">
        <div className="flex items-center gap-2">
          <div className="w-8 h-8 rounded-full bg-indigo-600 flex items-center justify-center">
            <span className="font-bold text-lg">F</span>
          </div>
          <span className="font-bold text-xl tracking-tight">FlowTask</span>
        </div>
        <div className="hidden md:flex gap-6 font-medium text-slate-300">
          <Link href="#features" className="hover:text-white transition">Features</Link>
          <Link href="#analytics" className="hover:text-white transition">Analytics</Link>
          <Link href="#pricing" className="hover:text-white transition">Pricing</Link>
        </div>
        <div>
          <button className="bg-indigo-600 hover:bg-indigo-700 text-white px-5 py-2.5 rounded-full font-medium transition-all shadow-lg shadow-indigo-500/20">
            Get the App
          </button>
        </div>
      </nav>

      {/* Hero Section */}
      <header className="pt-24 pb-32 px-6 text-center max-w-5xl mx-auto flex flex-col items-center">
        <div className="inline-block px-4 py-1.5 rounded-full bg-slate-800 border border-slate-700 text-emerald-400 text-sm font-medium mb-6">
          v1.0 Now available on iOS & Android
        </div>
        <h1 className="text-5xl md:text-7xl font-extrabold tracking-tight mb-8 leading-tight">
          Turn your <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-400 to-emerald-400">daily chaos</span> <br className="hidden md:block"/> into focused progress.
        </h1>
        <p className="text-xl text-slate-400 max-w-2xl mb-10 leading-relaxed">
          FlowTask is not just a to-do list. It's a personal productivity intelligence tool that helps you organize tasks, maintain deep focus, and understand your work patterns.
        </p>
        <div className="flex flex-col sm:flex-row gap-4 w-full sm:w-auto">
          <button className="bg-indigo-600 hover:bg-indigo-700 text-white text-lg px-8 py-4 rounded-full font-bold transition-all shadow-xl shadow-indigo-500/30 flex items-center justify-center gap-2">
            Download for Free
          </button>
          <button className="bg-slate-800 hover:bg-slate-700 text-white border border-slate-700 text-lg px-8 py-4 rounded-full font-bold transition-all flex items-center justify-center gap-2">
            View Live Demo
          </button>
        </div>
      </header>

      {/* Features Section */}
      <section id="features" className="py-24 bg-slate-950 px-6">
        <div className="max-w-7xl mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-3xl md:text-4xl font-bold mb-4">Everything you need to find your flow</h2>
            <p className="text-slate-400 text-lg">Minimalist design combined with powerful productivity engines.</p>
          </div>
          
          <div className="grid md:grid-cols-3 gap-8">
            <FeatureCard 
              title="Smart Task Management"
              description="Clutter-free task organization that lets you focus on what actually matters right now."
              icon="✓"
            />
            <FeatureCard 
              title="Built-in Focus Timer"
              description="Launch Pomodoro sessions directly from your tasks. No context switching necessary."
              icon="⏱"
            />
            <FeatureCard 
              title="Intelligent Reminders"
              description="AI-optimized notification schedules so you never miss a deadline or a focus session."
              icon="🔔"
            />
          </div>
        </div>
      </section>

      {/* Analytics Preview Section */}
      <section id="analytics" className="py-32 px-6 max-w-7xl mx-auto grid md:grid-cols-2 gap-16 items-center">
        <div>
          <h2 className="text-4xl font-bold mb-6 leading-tight">Understand exactly <br/><span className="text-indigo-400">how you work best.</span></h2>
          <p className="text-slate-400 text-lg mb-8 leading-relaxed">
            Stop guessing your productivity levels. FlowTask automatically tracks your completion behaviors and generates behavioral analytics so you can optimize your working hours.
          </p>
          <ul className="space-y-4">
            <ListItem>Discover your most productive hours in the day.</ListItem>
            <ListItem>Maintain and track daily completion streaks.</ListItem>
            <ListItem>Visualize your weekly velocity and focus time.</ListItem>
          </ul>
        </div>
        <div className="relative">
          <div className="aspect-square bg-gradient-to-tr from-indigo-900/50 to-emerald-900/20 rounded-3xl border border-slate-800 p-8 flex items-center justify-center shadow-2xl">
            <div className="text-center">
              <span className="text-6xl mb-4 block">📊</span>
              <p className="text-slate-500 font-medium">[Interactive Analytics Prototype area]</p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="py-24 px-6 text-center bg-indigo-900 border-t border-indigo-800">
        <h2 className="text-4xl font-bold mb-6 text-white">Ready to tame your daily chaos?</h2>
        <p className="text-indigo-200 text-xl max-w-2xl mx-auto mb-10">Join thousands of students, freelancers, and remote workers who have optimized their flow state.</p>
        <button className="bg-white hover:bg-slate-100 text-indigo-900 text-lg px-10 py-4 rounded-full font-bold transition-all shadow-xl">
          Get Started Today
        </button>
      </section>

      {/* Footer */}
      <footer className="border-t border-slate-800 py-12 px-6 text-center md:text-left">
        <div className="max-w-7xl mx-auto grid md:grid-cols-4 gap-8">
          <div className="col-span-2">
            <div className="flex items-center gap-2 mb-4 justify-center md:justify-start">
              <div className="w-6 h-6 rounded-full bg-indigo-600 flex items-center justify-center text-xs">F</div>
              <span className="font-bold text-lg">FlowTask</span>
            </div>
            <p className="text-slate-500 max-w-xs mx-auto md:mx-0">Building the future of personal productivity intelligence.</p>
          </div>
          <div>
            <h4 className="font-bold mb-4 text-slate-300">Legal</h4>
            <ul className="space-y-2 text-slate-500">
              <li><Link href="#" className="hover:text-indigo-400">Privacy Policy</Link></li>
              <li><Link href="#" className="hover:text-indigo-400">Terms of Service</Link></li>
              <li><Link href="#" className="hover:text-indigo-400">Data Usage</Link></li>
            </ul>
          </div>
          <div>
            <h4 className="font-bold mb-4 text-slate-300">Connect</h4>
            <ul className="space-y-2 text-slate-500">
              <li><Link href="#" className="hover:text-indigo-400">Twitter / X</Link></li>
              <li><Link href="#" className="hover:text-indigo-400">Product Hunt</Link></li>
              <li><Link href="#" className="hover:text-indigo-400">GitHub</Link></li>
            </ul>
          </div>
        </div>
        <div className="max-w-7xl mx-auto mt-12 pt-8 border-t border-slate-800 text-slate-600 text-sm flex flex-col md:flex-row justify-between items-center">
          <p>© 2026 FlowTask. All rights reserved.</p>
          <p className="mt-4 md:mt-0">Designed for builders.</p>
        </div>
      </footer>
    </div>
  );
}

function FeatureCard({ title, description, icon }: { title: string, description: string, icon: string }) {
  return (
    <div className="bg-slate-900 p-8 rounded-2xl border border-slate-800 hover:border-slate-700 transition group">
      <div className="w-12 h-12 bg-slate-800 rounded-xl flex items-center justify-center text-2xl mb-6 group-hover:bg-indigo-900/50 group-hover:text-indigo-400 transition">
        {icon}
      </div>
      <h3 className="text-xl font-bold mb-3">{title}</h3>
      <p className="text-slate-400 leading-relaxed">{description}</p>
    </div>
  );
}

function ListItem({ children }: { children: React.ReactNode }) {
  return (
    <li className="flex items-start gap-3">
      <div className="mt-1 bg-emerald-500/20 text-emerald-400 rounded-full p-1 border border-emerald-500/30">
        <svg className="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M5 13l4 4L19 7" />
        </svg>
      </div>
      <span className="text-slate-300">{children}</span>
    </li>
  );
}
