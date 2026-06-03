import Link from "next/link";

export default function DeleteAccount() {
  return (
    <div className="min-h-screen bg-[#0F172A] text-slate-50 font-sans p-6 md:p-24 flex flex-col items-center">
      <div className="max-w-2xl w-full bg-slate-900/40 border border-white/5 p-12 rounded-[2rem] backdrop-blur-2xl shadow-2xl mt-12">
        <div className="flex items-center gap-4 mb-8">
          <div className="w-12 h-12 rounded-2xl bg-red-500/20 flex items-center justify-center text-2xl border border-red-500/30">
            🗑️
          </div>
          <div>
            <h1 className="text-3xl font-black text-white">Account Deletion Request</h1>
            <p className="text-slate-400">Compliance & Privacy Request</p>
          </div>
        </div>

        <div className="space-y-6 leading-relaxed">
          <p className="text-slate-300">
            In accordance with Google Play Store policies and global data protection regulations, FlowTask provides a straightforward way to delete your account and all associated data.
          </p>

          <div className="bg-red-500/10 border border-red-500/20 p-6 rounded-2xl">
            <h2 className="text-red-400 font-bold mb-2">What data will be removed?</h2>
            <ul className="list-disc list-inside text-slate-400 space-y-1 text-sm">
              <li>Local identification data</li>
              <li>Personal productivity analytics and Intelligence IQ records</li>
              <li>Focus session history and heatmaps</li>
              <li>All tasks and pending reminders</li>
            </ul>
          </div>

          <h2 className="text-xl font-bold text-white mt-8">How to delete your data:</h2>
          
          <div className="space-y-4">
            <div className="flex gap-4">
               <div className="w-8 h-8 rounded-full bg-indigo-500/20 flex items-center justify-center text-indigo-400 font-bold shrink-0">1</div>
               <p className="text-slate-400">Open the <strong>FlowTask Mobile App</strong> on your device.</p>
            </div>
            <div className="flex gap-4">
               <div className="w-8 h-8 rounded-full bg-indigo-500/20 flex items-center justify-center text-indigo-400 font-bold shrink-0">2</div>
               <p className="text-slate-400">Navigate to the <strong>Profile &gt; Settings</strong> menu.</p>
            </div>
            <div className="flex gap-4">
               <div className="w-8 h-8 rounded-full bg-indigo-500/20 flex items-center justify-center text-indigo-400 font-bold shrink-0">3</div>
               <p className="text-slate-400">Tap on <strong>"Wipe Local Data"</strong> or <strong>"Delete Account"</strong> to purge all information from your device.</p>
            </div>
          </div>

          <h2 className="text-xl font-bold text-white mt-8">Privacy Notice</h2>
          <p className="text-slate-400">
            FlowTask operates as a 100% offline application. We do not store your data on our servers, so your data is effectively "deleted" from our system by virtue of it never being there in the first place.
          </p>

          <Link href="/" className="inline-block mt-8 bg-slate-800 hover:bg-slate-700 text-white px-8 py-3 rounded-full font-bold transition-all border border-white/5">
            Back to Home
          </Link>
        </div>
      </div>
      
      <p className="mt-12 text-slate-600 text-sm">
        Secure Local-First Data Architecture.
      </p>
    </div>
  );
}
