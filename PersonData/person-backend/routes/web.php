<?php 

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;

Route::get('/', function () {

    $logs = [];

    if (Storage::exists('person_logs.json')) {
        $logs = json_decode(Storage::get('person_logs.json'), true);

        // Sort latest first
        usort($logs, function ($a, $b) {
            return strtotime($b['timestamp']) - strtotime($a['timestamp']);
        });
    }

    return view('logs', ['logs' => $logs]);
});
