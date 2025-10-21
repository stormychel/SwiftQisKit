//
//  SwiftQisKitApp.swift
//  SwiftQisKit
//
//  Created by Michel Storms on 21/10/2025.
//

import SwiftUI
import CoreData
import PythonKit

@main
struct SwiftQisKitApp: App {
    let persistenceController = PersistenceController.shared

    
    //
    init() {
        let sys = Python.import("sys")
        print("Python:", sys.version)

        let qiskit = Python.import("qiskit")
        let QuantumCircuit = qiskit.QuantumCircuit
        let Aer = qiskit.Aer
        let execute = qiskit.execute

        let qc = QuantumCircuit(2, 2)
        qc.h(0)
        qc.cx([0, 1])
        qc.measure([0, 1], [0, 1])

        let backend = Aer.get_backend("qasm_simulator")
        let job = execute(qc, backend, shots: 1024)
        let result = job.result()
        let counts = result.get_counts(qc)
        print("Counts:", counts)
    }
    //
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
