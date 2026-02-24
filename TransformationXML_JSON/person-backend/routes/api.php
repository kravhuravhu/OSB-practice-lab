<?php 

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::post('/person', function (Request $request) {

    $data = $request->json()->all();

    return response()->json([
        'Root-Element' => [
            'status' => 'Success',
            'message' => 'Person processed successfully',
            'received' => $data
        ]
    ]);
});
