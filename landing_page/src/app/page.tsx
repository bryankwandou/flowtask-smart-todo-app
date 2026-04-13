import Image from "next/image";
import Link from "next/link";

export default function Home() {
  return (
    <div className="min-h-screen bg-[#0F172A] text-slate-50 font-sans selection:bg-indigo-500 selection:text-white overflow-x-hidden">
      {/* Decorative Background Blur */}
      <div className="fixed top-0 left-0 w-full h-full overflow-hidden pointer-events-none z-0">
        <div className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-indigo-600/10 rounded-full blur-[120px]"></div>
        <div className="absolute bottom-[10%] right-[-5%] w-[30%] h-[30%] bg-emerald-600/10 rounded-full blur-[100px]"></div>
      </div>

      {/* Navigation */}
      <nav className="relative z-10 flex items-center justify-between p-6 max-w-7xl mx-auto backdrop-blur-md bg-slate-950/20 sticky top-0 border-b border-white/5">
        <div className="flex items-center gap-3 group cursor-pointer">
          <div className="w-10 h-10 rounded-xl bg-gradient-to-br from-indigo-600 to-indigo-800 flex items-center justify-center shadow-lg shadow-indigo-500/20 rotate-3 group-hover:rotate-0 transition-all duration-500">
            <span className="font-bold text-xl text-white">F</span>
          </div>
          <span className="font-extrabold text-2xl tracking-tighter text-white">Flow<span className="text-indigo-400">Task</span></span>
        </div>
        <div className="hidden md:flex gap-8 font-medium text-slate-400">
          <Link href="#features" className="hover:text-indigo-400 transition-colors">Features</Link>
          <Link href="#analytics" className="hover:text-indigo-400 transition-colors">Intelligence</Link>
          <Link href="#compliance" className="hover:text-indigo-400 transition-colors">Compliance</Link>
        </div>
        <div>
          <button className="bg-indigo-600 hover:bg-indigo-500 text-white px-6 py-2.5 rounded-full font-semibold transition-all shadow-lg shadow-indigo-500/20 active:scale-95">
            Download App
          </button>
        </div>
      </nav>

      {/* Hero Section */}
      <header className="relative z-10 pt-32 pb-40 px-6 text-center max-w-6xl mx-auto flex flex-col items-center">
        <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full bg-indigo-500/10 border border-indigo-500/20 text-indigo-400 text-sm font-semibold mb-8 animate-fade-in">
          <span className="relative flex h-2 w-2">
            <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
            <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
          </span>
          v1.0 Ready for Battle - Now on Play Store
        </div>
        <h1 className="text-6xl md:text-8xl font-black tracking-tight mb-10 leading-[1] text-white">
          Turn Daily Chaos <br/>
          Into <span className="text-transparent bg-clip-text bg-gradient-to-r from-indigo-400 via-emerald-400 to-indigo-400">Focused Progress.</span>
        </h1>
        <p className="text-xl text-slate-400 max-w-3xl mb-12 leading-relaxed font-medium">
          FlowTask isn't just another to-do list. It's a personal productivity intelligence tool designed to help you organize, focus, and finally understand your unique work patterns.
        </p>
        <div className="flex flex-col sm:flex-row gap-6 w-full sm:w-auto">
          <button className="bg-white text-indigo-950 text-lg px-10 py-5 rounded-full font-black transition-all hover:scale-105 active:scale-95 shadow-2xl shadow-white/10 flex items-center justify-center gap-3">
            Get Started for Free
            <svg className="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={3} d="M14 5l7 7m0 0l-7 7m7-7H3" />
            </svg>
          </button>
          <button className="bg-slate-800/50 backdrop-blur-md hover:bg-slate-800 text-white border border-white/10 text-lg px-10 py-5 rounded-full font-bold transition-all flex items-center justify-center gap-2">
            See the Analytics
          </button>
        </div>
      </header>

      {/* Features Grid */}
      <section id="features" className="relative z-10 py-32 bg-slate-950/50 px-6 border-y border-white/5">
        <div className="max-w-7xl mx-auto">
          <div className="text-center mb-24">
            <h2 className="text-4xl md:text-5xl font-black mb-6 text-white tracking-tight">Built for Deep Work.</h2>
            <p className="text-slate-400 text-xl max-w-2xl mx-auto">We combined minimalist task management with high-performance focus mechanics.</p>
          </div>
          
          <div className="grid md:grid-cols-3 gap-10">
            <FeatureCard 
              title="Productivity IQ"
              description="Our custom engine translates your completion habits into actionable intelligence scores."
              icon="🧠"
              accent="indigo"
            />
            <FeatureCard 
              title="Focus Mode 2.0"
              description="A glassmorphic deep work timer that protects your flow state from digital distractions."
              icon="⏱️"
              accent="emerald"
            />
            <FeatureCard 
              title="Streak Mastery"
              description="Gamified consistency tracking that prioritizes quality progress over quantity."
              icon="🔥"
              accent="indigo"
            />
          </div>
        </div>
      </      {/* Testimonials */}
      <section id="testimonials" className="relative z-10 py-32 px-6">
        <div className="max-w-7xl mx-auto">
          <div className="text-center mb-24">
            <h2 className="text-4xl md:text-5xl font-black mb-6 text-white tracking-tight">Trusted by High-Performers.</h2>
            <p className="text-slate-400 text-xl max-w-2xl mx-auto">See why thousands of students and founders are switching to FlowTask.</p>
          </div>
          
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            <TestimonialCard 
              name="Sarah Chen"
              role="Senior Architect @ DesignCo"
              content="FlowTask's Focus Mode is a game changer. I've increased my deep work sessions by 40% in just two weeks. The analytics are scary accurate."
              avatar="👩‍💻"
            />
            <TestimonialCard 
              name="James Miller"
              role="Full-stack Developer"
              content="The minimal UI paired with the Productivity IQ engine is exactly what I needed. No more bloated dashboard, just pure performance tracking."
              avatar="👨‍💻"
            />
            <TestimonialCard 
              name="Elena Rodriguez"
              role="Med Student"
              content="As a student, the intelligent reminders and streak tracking keep me motivated through the hardest exam weeks. Essential tool."
              avatar="👩‍🎓"
            />
          </div>
        </div>
      </section>

      {/* Compliance Section (FOR GOOGLE PLAY) */}
      <section id="compliance" className="relative z-10 py-32 px-6 bg-[#0B1120]">
        <div className="max-w-4xl mx-auto bg-slate-900/40 border border-white/5 p-12 rounded-[2rem] backdrop-blur-2xl shadow-2xl">
          <div className="flex items-center gap-4 mb-8">
            <div className="w-12 h-12 rounded-2xl bg-emerald-500/20 flex items-center justify-center text-2xl border border-emerald-500/30">
              🛡️
            </div>
            <div>
              <h2 className="text-3xl font-black text-white">Data Safety & Compliance</h2>
              <p className="text-slate-400">Your privacy is our primary productivity metric.</p>
            </div>
          </div>
          
          <div className="grid md:grid-cols-2 gap-12">
            <div>
              <h3 className="text-xl font-bold mb-4 text-emerald-400">Account Deletion</h3>
              <p className="text-slate-400 leading-relaxed mb-6">
                In compliance with Google Play Store policies, we provide a full, irreversible account and data deletion path. You can delete your account directly through the app settings or by submitting a request below.
              </p>
              <Link href="/delete-account" className="text-indigo-400 font-bold hover:underline inline-flex items-center gap-2">
                Go to Deletion Request Form
                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                </svg>
              </Link>
            </div>
            <div>
              <h3 className="text-xl font-bold mb-4 text-indigo-400">Data Usage</h3>
              <p className="text-slate-400 leading-relaxed font-medium">
                FlowTask only collects data essential for syncing your tasks and generating your productivity intelligence reports. We use enterprise-grade Firebase encryption for all user content.
              </p>
              <ul className="mt-4 space-y-2">
                <ListItem>No third-party data selling</ListItem>
                <ListItem>End-to-end task encryption</ListItem>
                <ListItem>GDPR & CCPA Compliant</ListItem>
              </ul>
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="relative z-10 border-t border-white/5 py-24 px-6 bg-slate-950/80">
        <div className="max-w-7xl mx-auto grid md:grid-cols-4 gap-16">
          <div className="col-span-2">
            <div className="flex items-center gap-3 mb-6">
              <div className="w-8 h-8 rounded-lg bg-indigo-600 flex items-center justify-center font-bold">F</div>
              <span className="font-black text-xl tracking-tighter">FlowTask</span>
            </div>
            <p className="text-slate-500 max-w-xs leading-relaxed font-medium">
              Transforming the way modern professionals and students manage their cognitive load.
            </p>
            <div className="flex gap-4 mt-8">
              <div className="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center text-slate-400 hover:text-white transition-colors cursor-pointer border border-white/5">𝕏</div>
              <div className="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center text-slate-400 hover:text-white transition-colors cursor-pointer border border-white/5">📸</div>
              <div className="w-10 h-10 rounded-full bg-slate-800 flex items-center justify-center text-slate-400 hover:text-white transition-colors cursor-pointer border border-white/5">💼</div>
            </div>
          </div>
          <div>
            <h4 className="font-bold mb-6 text-slate-300 uppercase tracking-widest text-xs">Legal Integrity</h4>
            <ul className="space-y-4 text-slate-500 font-medium">
              <li><Link href="/privacy" className="hover:text-white transition-colors">Privacy Policy</Link></li>
              <li><Link href="/terms" className="hover:text-white transition-colors">Terms of Service</Link></li>
              <li><Link href="/disclaimer" className="hover:text-white transition-colors">Disclaimer</Link></li>
              <li><Link href="/delete-account" className="hover:text-white transition-colors">Data Deletion</Link></li>
            </ul>
          </div>
          <div>
            <h4 className="font-bold mb-6 text-slate-300 uppercase tracking-widest text-xs">Platform</h4>
            <ul className="space-y-4 text-slate-500 font-medium">
              <li><Link href="#" className="hover:text-white transition-colors">Google Play Store</Link></li>
              <li><Link href="#" className="hover:text-white transition-colors">App Store</Link></li>
              <li><Link href="/docs/architecture" className="hover:text-white transition-colors">System Architecture</Link></li>
              <li><Link href="#" className="hover:text-white transition-colors">Download Kit</Link></li>
            </ul>
          </div>
        </div>
        <div className="max-w-7xl mx-auto mt-24 pt-8 border-t border-white/5 text-slate-600 text-sm flex flex-col md:flex-row justify-between items-center font-medium">
          <p>© 2026 FlowTask — Built by individuals who value time.</p>
          <div className="flex gap-8 mt-6 md:mt-0">
             <span>v1.0.8 Release</span>
             <span>Firebase Infrastructure</span>
          </div>
        </div>
      </footer>
    </div>
  );
}

function TestimonialCard({ name, role, content, avatar }: { name: string, role: string, content: string, avatar: string }) {
  return (
    <div className="bg-slate-900/40 p-8 rounded-3xl border border-white/5 shadow-xl backdrop-blur-sm">
      <div className="text-3xl mb-6">{avatar}</div>
      <p className="text-slate-300 italic mb-8 leading-relaxed">"{content}"</p>
      <div>
        <h4 className="font-bold text-white">{name}</h4>
        <p className="text-indigo-400 text-sm">{role}</p>
      </div>
    </div>
  );
}

function FeatureCard({ title, description, icon, accent }: { title: string, description: string, icon: string, accent: 'indigo' | 'emerald' }) {
  return (
    <div className="bg-slate-900/50 backdrop-blur-xl p-10 rounded-[2.5rem] border border-white/5 hover:border-indigo-500/30 transition-all duration-500 group shadow-xl">
      <div className={`w-14 h-14 rounded-2xl flex items-center justify-center text-3xl mb-8 group-hover:scale-110 transition-transform duration-500 ${accent === 'indigo' ? 'bg-indigo-500/10 text-indigo-400' : 'bg-emerald-500/10 text-emerald-400'}`}>
        {icon}
      </div>
      <h3 className="text-2xl font-black mb-4 text-white">{title}</h3>
      <p className="text-slate-400 leading-relaxed font-medium">{description}</p>
    </div>
  );
}

function ListItem({ children }: { children: React.ReactNode }) {
  return (
    <li className="flex items-start gap-3">
      <div className="mt-1 bg-emerald-500/20 text-emerald-400 rounded-full p-1 border border-emerald-500/30 shadow-lg shadow-emerald-500/10">
        <svg className="w-3 h-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={4} d="M5 13l4 4L19 7" />
        </svg>
      </div>
      <span className="text-slate-300 font-medium">{children}</span>
    </li>
  );
}


