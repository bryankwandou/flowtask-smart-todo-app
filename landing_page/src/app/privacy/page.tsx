import Link from "next/link";

export const metadata = {
  title: "Privacy Policy | FlowTask",
  description: "Official Privacy Policy for the FlowTask productivity application.",
};

export default function PrivacyPage() {
  const lastUpdated = "April 11, 2026";

  return (
    <div className="min-h-screen bg-slate-950 text-slate-100 font-sans selection:bg-indigo-500 selection:text-white pb-24">
      {/* Simple Navigation */}
      <nav className="p-6 max-w-4xl mx-auto flex items-center justify-between border-b border-white/10 mb-12">
        <Link href="/" className="flex items-center gap-2 group">
          <div className="w-8 h-8 rounded-full bg-indigo-600 flex items-center justify-center text-xs font-bold transition-transform group-hover:scale-110">F</div>
          <span className="font-bold text-lg">FlowTask</span>
        </Link>
        <Link href="/" className="text-slate-400 hover:text-white transition">Back to Home</Link>
      </nav>

      <main className="max-w-4xl mx-auto px-6">
        <h1 className="text-4xl md:text-5xl font-extrabold mb-4 tracking-tight">Privacy Policy</h1>
        <p className="text-slate-400 mb-12">Last Updated: {lastUpdated}</p>

        <section className="space-y-12">
          <div className="prose prose-invert prose-indigo max-w-none">
            <h2 className="text-2xl font-bold text-white mb-4">1. Introduction</h2>
            <p className="text-slate-300 leading-relaxed">
              Welcome to FlowTask. We respect your privacy and are committed to protecting your personal data. 
              This Privacy Policy explains how we collect, use, and safeguard your information when you use our mobile application and related services.
              By using FlowTask, you agree to the collection and use of information in accordance with this policy.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">2. Data We Collect</h2>
            <div className="bg-slate-900/50 border border-white/5 rounded-2xl p-6 mb-6">
              <h3 className="text-lg font-semibold text-indigo-400 mb-3">Directly Provided Data:</h3>
              <ul className="list-disc pl-6 space-y-2 text-slate-300">
                <li><strong>Account Information:</strong> Email address, display name, and unique user ID provided via Firebase Authentication.</li>
                <li><strong>Task Content:</strong> Titles, descriptions, priorities, and deadlines of tasks you create.</li>
                <li><strong>Usage Data:</strong> Focus timer durations, completion streaks, and productivity statistics.</li>
              </ul>
            </div>
            
            <div className="bg-slate-900/50 border border-white/5 rounded-2xl p-6">
              <h3 className="text-lg font-semibold text-indigo-400 mb-3">Automatically Collected Data (via Firebase SDKs):</h3>
              <ul className="list-disc pl-6 space-y-2 text-slate-300">
                <li><strong>Device Information:</strong> Model, OS version, application version, and unique device identifiers.</li>
                <li><strong>Crash Reports:</strong> Anonymized data regarding application crashes via Firebase Crashlytics.</li>
                <li><strong>Analytics:</strong> Aggregated in-app navigation and feature usage patterns via Firebase Analytics.</li>
              </ul>
            </div>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">3. How We Use Your Data</h2>
            <p className="text-slate-300 leading-relaxed">
              We use the collected data for various purposes, including:
            </p>
            <ul className="list-disc pl-6 space-y-2 text-slate-300 mt-4">
              <li>Providing and maintaining the FlowTask service.</li>
              <li>Generating personalized productivity insights and behavioral analytics.</li>
              <li>Processing notifications and intelligent reminders.</li>
              <li>Monitoring app stability and optimizing performance.</li>
              <li>Detecting and preventing unauthorized access or security breaches.</li>
            </ul>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">4. Data Safety & Infrastructure</h2>
            <p className="text-slate-300 leading-relaxed italic border-l-4 border-indigo-600 pl-4 mb-6">
              FlowTask utilizes Google Firebase as its primary backend infrastructure.
            </p>
            <p className="text-slate-300 leading-relaxed">
              Your data is stored securely in **Cloud Firestore** and synchronized across your devices. 
              Transmission of data is strictly encrypted via HTTPS/TLS. We do not sell your personal information to third-party advertisers.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">5. Your Account Management & Deletion</h2>
            <p className="text-slate-300 leading-relaxed">
              We value your control over your data. You may update your profile information directly within the app.
            </p>
            <div className="bg-amber-950/20 border border-amber-900/30 rounded-2xl p-6 mt-6">
              <h3 className="text-lg font-semibold text-amber-500 mb-2">Account Deletion:</h3>
              <p className="text-slate-300 leading-relaxed">
                You can delete your account and all associated data (tasks, analytics, and metadata) at any time via the **Settings &gt; Delete Account** option in the app. 
                Upon clicking "Delete Account", your Firestore data is purged immediately, and your authentication record is removed.
              </p>
            </div>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">6. Changes to This Policy</h2>
            <p className="text-slate-300 leading-relaxed">
              We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date at the top.
            </p>

            <h2 className="text-2xl font-bold text-white mt-12 mb-4">7. Contact Us</h2>
            <p className="text-slate-300 leading-relaxed">
              If you have any questions about this Privacy Policy, please contact us at:
              <br/>
              <span className="text-indigo-400 font-medium">compliance@flowtaskapp.com</span>
            </p>
          </div>
        </section>
      </main>

      <footer className="max-w-4xl mx-auto px-6 mt-24 pt-8 border-t border-white/5 text-slate-500 text-sm text-center">
        &copy; 2026 FlowTask. Built for focus.
      </footer>
    </div>
  );
}
