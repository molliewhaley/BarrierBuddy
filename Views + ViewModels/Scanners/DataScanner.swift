//
//  DataScanner.swift
//  BarrierBuddyApp
//
//  Created by Mollie Whaley on 9/14/23.
//

import SwiftUI
import VisionKit

struct DataScanner: UIViewControllerRepresentable {
    @ObservedObject var textScannerVM: TextScannerVM
    @Binding var languageCode: String
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
                            recognizedDataTypes: [.text()],
                            qualityLevel: .balanced,
                            isHighlightingEnabled: false
                        )
        
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if textScannerVM.startScanning {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScanner
        
        init(_ parent: DataScanner) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .text(let text):
                Task {
                    await parent.textScannerVM.translateText(using: text.transcript, to: parent.languageCode)
                }
            default: break
            }
        }
    }
}
