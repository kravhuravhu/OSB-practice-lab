<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;

Route::post('/person', function (Request $request) {

    $data = $request->json()->all();

    $response = [
        'Root-Element' => [
            'status' => 'Success',
            'message' => 'Person processed successfully',
            'received' => $data
        ]
    ];

    $logs = [];

    if (Storage::exists('person_logs.json')) {
        $logs = json_decode(Storage::get('person_logs.json'), true);
    }

    $logs[] = [
        'timestamp' => now()->toDateTimeString(),
        'request'   => $data,
        'response'  => $response
    ];

    Storage::put('person_logs.json', json_encode($logs, JSON_PRETTY_PRINT));

    return response()->json($response);
});
