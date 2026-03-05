<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Person API Logs</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
        
        * {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }
        
        .json-viewer {
            background: #1e1e1e;
            border-radius: 0.5rem;
            padding: 1rem;
            color: #d4d4d4;
            font-family: 'JetBrains Mono', 'Fira Code', monospace;
            font-size: 0.875rem;
            line-height: 1.5;
            overflow-x: auto;
            white-space: pre-wrap;
            word-wrap: break-word;
        }
        
        .json-key { color: #9cdcfe; }
        .json-string { color: #ce9178; }
        .json-number { color: #b5cea8; }
        .json-boolean { color: #569cd6; }
        .json-null { color: #569cd6; }
        
        .method-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        
        .status-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .status-success { background: #10b98120; color: #059669; }
        .status-error { background: #ef444420; color: #dc2626; }
        .status-warning { background: #f59e0b20; color: #d97706; }
        
        .animate-fade-in {
            animation: fadeIn 0.3s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .log-card {
            transition: all 0.2s ease;
        }
        
        .log-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }
        
        .copy-button {
            opacity: 0;
            transition: opacity 0.2s ease;
        }
        
        .group:hover .copy-button {
            opacity: 1;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">

    <!-- Header with stats -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-8">
            <div>
                <h1 class="text-3xl font-bold text-gray-900 flex items-center gap-3">
                    <i class="fas fa-history text-blue-500"></i>
                    Person API Transaction Logs
                </h1>
                <p class="mt-2 text-gray-600">
                    Monitor and debug API requests to the Person service
                </p>
            </div>
            
            <!-- Stats cards -->
            <div class="mt-4 md:mt-0 flex gap-3">
                <div class="bg-white rounded-xl shadow-sm px-6 py-4 border border-gray-200">
                    <div class="text-sm text-gray-500">Total Logs</div>
                    <div class="text-2xl font-bold text-gray-900">{{ count($logs) }}</div>
                </div>
                <div class="bg-white rounded-xl shadow-sm px-6 py-4 border border-gray-200">
                    <div class="text-sm text-gray-500">Last 24h</div>
                    <div class="text-2xl font-bold text-gray-900">
                        {{ collect($logs)->filter(function($log) {
                            return strtotime($log['timestamp']) > strtotime('-24 hours');
                        })->count() }}
                    </div>
                </div>
            </div>
        </div>

        <!-- Search and filter bar -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-4 mb-6">
            <div class="flex flex-col sm:flex-row gap-4">
                <div class="flex-1 relative">
                    <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                    <input type="text" 
                           placeholder="Search logs..." 
                           class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                           id="searchInput">
                </div>
                <div class="flex gap-2">
                    <select class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500" id="methodFilter">
                        <option value="">All Methods</option>
                        <option value="GET">GET</option>
                        <option value="POST">POST</option>
                        <option value="PUT">PUT</option>
                        <option value="DELETE">DELETE</option>
                    </select>
                    <select class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500" id="statusFilter">
                        <option value="">All Status</option>
                        <option value="success">Success (2xx)</option>
                        <option value="error">Error (4xx/5xx)</option>
                    </select>
                    <button class="px-4 py-2 bg-gray-100 text-gray-700 rounded-lg hover:bg-gray-200 transition-colors" id="resetFilters">
                        <i class="fas fa-undo-alt mr-2"></i>Reset
                    </button>
                </div>
            </div>
        </div>

        <!-- Logs container -->
        <div class="space-y-4" id="logsContainer">
            @forelse($logs as $index => $log)
                @php
                    $method = $log['request']['method'] ?? 'GET';
                    $statusCode = $log['response']['status'] ?? 200;
                    $statusClass = $statusCode >= 200 && $statusCode < 300 ? 'status-success' : 
                                  ($statusCode >= 400 && $statusCode < 600 ? 'status-error' : 'status-warning');
                    $responseTime = $log['response']['duration'] ?? rand(100, 1000); // You'd have this from your actual data
                @endphp
                
                <div class="log-card bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden animate-fade-in group"
                     data-method="{{ $method }}"
                     data-status="{{ $statusCode >= 200 && $statusCode < 300 ? 'success' : 'error' }}"
                     data-search="{{ strtolower(json_encode($log)) }}">
                    
                    <!-- Card header -->
                    <div class="border-b border-gray-200 bg-gray-50 px-6 py-4">
                        <div class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                            <div class="flex items-center gap-4">
                                <span class="method-badge {{ $method === 'GET' ? 'bg-blue-100 text-blue-700' : 
                                                              ($method === 'POST' ? 'bg-green-100 text-green-700' : 
                                                              ($method === 'PUT' ? 'bg-yellow-100 text-yellow-700' : 
                                                              'bg-red-100 text-red-700')) }}">
                                    {{ $method }}
                                </span>
                                <span class="status-badge {{ $statusClass }}">
                                    {{ $statusCode }}
                                </span>
                                <span class="text-sm text-gray-500">
                                    <i class="far fa-clock mr-1"></i>
                                    {{ \Carbon\Carbon::parse($log['timestamp'])->diffForHumans() }}
                                </span>
                            </div>
                            
                            <div class="flex items-center gap-2 text-sm">
                                <span class="text-gray-500">
                                    <i class="far fa-hourglass-half mr-1"></i>
                                    {{ $responseTime }}ms
                                </span>
                                <span class="text-gray-300">|</span>
                                <span class="text-gray-500">
                                    <i class="fas fa-exchange-alt mr-1"></i>
                                    {{ $log['request']['endpoint'] ?? '/api/person' }}
                                </span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Card body with request/response -->
                    <div class="p-6">
                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                            <!-- Request section -->
                            <div>
                                <div class="flex items-center justify-between mb-2">
                                    <h3 class="text-sm font-semibold text-gray-700 uppercase tracking-wider">
                                        <i class="fas fa-paper-plane text-blue-500 mr-2"></i>
                                        Request
                                    </h3>
                                    <button onclick="copyToClipboard(this, 'request-{{ $index }}')" 
                                            class="copy-button text-xs text-gray-500 hover:text-gray-700 transition-colors">
                                        <i class="far fa-copy mr-1"></i>Copy
                                    </button>
                                </div>
                                <div id="request-{{ $index }}" class="json-viewer">
                                    {!! formatJsonForDisplay($log['request']) !!}
                                </div>
                            </div>
                            
                            <!-- Response section -->
                            <div>
                                <div class="flex items-center justify-between mb-2">
                                    <h3 class="text-sm font-semibold text-gray-700 uppercase tracking-wider">
                                        <i class="fas fa-reply text-green-500 mr-2"></i>
                                        Response
                                    </h3>
                                    <button onclick="copyToClipboard(this, 'response-{{ $index }}')" 
                                            class="copy-button text-xs text-gray-500 hover:text-gray-700 transition-colors">
                                        <i class="far fa-copy mr-1"></i>Copy
                                    </button>
                                </div>
                                <div id="response-{{ $index }}" class="json-viewer">
                                    {!! formatJsonForDisplay($log['response']) !!}
                                </div>
                            </div>
                        </div>
                        
                        <!-- Expandable raw data (optional) -->
                        <div class="mt-4 text-right">
                            <button onclick="toggleRawData(this, 'raw-{{ $index }}')" 
                                    class="text-xs text-gray-500 hover:text-gray-700 transition-colors">
                                <i class="fas fa-code mr-1"></i>
                                Show raw JSON
                            </button>
                        </div>
                        <div id="raw-{{ $index }}" class="hidden mt-2">
                            <pre class="text-xs bg-gray-900 text-gray-100 p-3 rounded-lg overflow-x-auto">{{ json_encode($log, JSON_PRETTY_PRINT) }}</pre>
                        </div>
                    </div>
                </div>
            @empty
                <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-12 text-center">
                    <div class="text-gray-400 mb-4">
                        <i class="fas fa-clipboard-list text-6xl"></i>
                    </div>
                    <h3 class="text-lg font-medium text-gray-900 mb-2">No logs yet</h3>
                    <p class="text-gray-500">When API requests are made to the Person service, they'll appear here.</p>
                </div>
            @endforelse
        </div>
        
        <!-- Load more button (if paginated) -->
        @if(count($logs) > 0)
            <div class="mt-8 text-center">
                <button class="px-6 py-3 bg-white border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 transition-colors shadow-sm">
                    <i class="fas fa-sync-alt mr-2"></i>
                    Load More
                </button>
            </div>
        @endif
    </div>

    <script>
        // JSON syntax highlighting function
        function formatJsonForDisplay(json) {
            if (!json) return '<span class="json-null">null</span>';
            
            const jsonString = JSON.stringify(json, null, 2);
            return jsonString.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
                .replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
                    let cls = 'json-number';
                    if (/^"/.test(match)) {
                        if (/:$/.test(match)) {
                            cls = 'json-key';
                            match = match.replace(/"/g, '');
                        } else {
                            cls = 'json-string';
                        }
                    } else if (/true|false/.test(match)) {
                        cls = 'json-boolean';
                    } else if (/null/.test(match)) {
                        cls = 'json-null';
                    }
                    return '<span class="' + cls + '">' + match + '</span>';
                });
        }

        // Copy to clipboard function
        function copyToClipboard(button, elementId) {
            const element = document.getElementById(elementId);
            const text = element.innerText || element.textContent;
            
            navigator.clipboard.writeText(text).then(() => {
                const originalHtml = button.innerHTML;
                button.innerHTML = '<i class="fas fa-check mr-1"></i>Copied!';
                setTimeout(() => {
                    button.innerHTML = originalHtml;
                }, 2000);
            });
        }

        // Toggle raw data
        function toggleRawData(button, elementId) {
            const element = document.getElementById(elementId);
            element.classList.toggle('hidden');
            button.innerHTML = element.classList.contains('hidden') ? 
                '<i class="fas fa-code mr-1"></i>Show raw JSON' : 
                '<i class="fas fa-eye-slash mr-1"></i>Hide raw JSON';
        }

        // Filtering functionality
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const methodFilter = document.getElementById('methodFilter');
            const statusFilter = document.getElementById('statusFilter');
            const resetBtn = document.getElementById('resetFilters');
            const logs = document.querySelectorAll('.log-card');

            function filterLogs() {
                const searchTerm = searchInput.value.toLowerCase();
                const method = methodFilter.value;
                const status = statusFilter.value;

                logs.forEach(log => {
                    let show = true;
                    
                    if (method && log.dataset.method !== method) {
                        show = false;
                    }
                    
                    if (status && log.dataset.status !== status) {
                        show = false;
                    }
                    
                    if (searchTerm && !log.dataset.search.includes(searchTerm)) {
                        show = false;
                    }
                    
                    log.style.display = show ? 'block' : 'none';
                });
            }

            searchInput.addEventListener('input', filterLogs);
            methodFilter.addEventListener('change', filterLogs);
            statusFilter.addEventListener('change', filterLogs);
            
            resetBtn.addEventListener('click', function() {
                searchInput.value = '';
                methodFilter.value = '';
                statusFilter.value = '';
                filterLogs();
            });
        });

        // Auto-refresh (optional)
        // setInterval(() => {
        //     window.location.reload();
        // }, 30000); // Refresh every 30 seconds
    </script>
</body>
</html>

@php
function formatJsonForDisplay($data) {
    if (!$data) return '<span class="json-null">null</span>';
    
    $json = json_encode($data, JSON_PRETTY_PRINT);
    $json = htmlspecialchars($json, ENT_NOQUOTES, 'UTF-8');
    
    // Simple syntax highlighting
    $json = preg_replace(
        '/("(.*?)")(?=\s*:)/',
        '<span class="json-key">$1</span>',
        $json
    );
    
    $json = preg_replace(
        '/:(\s*)"(.*?)"/',
        ':<span class="json-string">"$2"</span>',
        $json
    );
    
    $json = preg_replace(
        '/:(\s*)(\d+)/',
        ':<span class="json-number">$2</span>',
        $json
    );
    
    $json = preg_replace(
        '/:(\s*)(true|false)/',
        ':<span class="json-boolean">$2</span>',
        $json
    );
    
    $json = preg_replace(
        '/:(\s*)(null)/',
        ':<span class="json-null">$2</span>',
        $json
    );
    
    return $json;
}
@endphp
