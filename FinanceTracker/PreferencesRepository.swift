//
//  PreferencesRepository.swift
//  FinanceTracker
//
//  Created by Quentin Cornu on 30/10/2022.
//

import Foundation

class PreferenceRepository {
		
	enum PreferenceRepositoryError: Error {
		case preferencesFileNotFound
	}
	
	// MARK: - Public methods
	
	func createPreferenceFileIfNedded() {
		
		do {
			let outfile = try fileURL()
			let fileManager = FileManager.default
			if !fileManager.fileExists(atPath: outfile.relativePath) {
				let userPreferences = UserPreferences()
				let data = try JSONEncoder().encode(userPreferences)
				try data.write(to: outfile)
			}
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func load(completion: @escaping (Result<UserPreferences, Error>)->Void) {
		DispatchQueue.global(qos: .background).async {
			do {
				let fileURL = try self.fileURL()
				guard let file = try? FileHandle(forReadingFrom: fileURL) else {
					DispatchQueue.main.async {
						completion(.failure(PreferenceRepository.PreferenceRepositoryError.preferencesFileNotFound))
					}
					return
				}
				let userPreferences = try JSONDecoder().decode(UserPreferences.self, from: file.availableData)
				DispatchQueue.main.async {
					completion(.success(userPreferences))
				}
			} catch {
				DispatchQueue.main.async {
					completion(.failure(error))
				}
			}
		}
	}
	
	func save(userPreferences: UserPreferences, completion: @escaping (Result<Void, Error>)->Void) {
		DispatchQueue.global(qos: .background).async {
			do {
				let data = try JSONEncoder().encode(userPreferences)
				let outfile = try self.fileURL()
				try data.write(to: outfile)
				DispatchQueue.main.async {
					completion(.success(()))
				}
			} catch {
				DispatchQueue.main.async {
					completion(.failure(error))
				}
			}
		}
	}
	
	// MARK: - Private methods
	
	private func fileURL() throws -> URL {
		let path = try FileManager.default.url(for: .documentDirectory,
									in: .userDomainMask,
									appropriateFor: nil,
									create: false)
		let url = path.appendingPathComponent("user_preferences.data")
		return url
	}
}
