#!/usr/bin/env python3
"""
Test script for Todo Console App components.
Verifies that all modules load correctly and basic functionality works.
"""

import sys
import os
import tempfile
import json

# Add the project root to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

def test_imports():
    """Test that all modules can be imported."""
    print("Testing imports...")
    try:
        from models.task import Task
        from services.task_service import TaskService
        from ui.console_ui import ConsoleUI
        print("✓ All modules imported successfully")
        return True
    except ImportError as e:
        print(f"✗ Import failed: {e}")
        return False

def test_task_model():
    """Test Task model functionality."""
    print("\nTesting Task model...")
    try:
        from models.task import Task
        from datetime import datetime
        
        # Test creation
        task = Task(id=1, title="Test Task", description="Test Description")
        assert task.id == 1
        assert task.title == "Test Task"
        assert task.description == "Test Description"
        assert task.completed == False
        assert isinstance(task.created_at, datetime)
        assert isinstance(task.updated_at, datetime)
        print("✓ Task creation works")
        
        # Test validation
        try:
            Task(id=1, title="")  # Should fail
            print("✗ Empty title validation failed")
            return False
        except ValueError:
            print("✓ Empty title validation works")
        
        # Test update method
        task.update(title="Updated Title")
        assert task.title == "Updated Title"
        print("✓ Task update works")
        
        # Test toggle completion
        original_status = task.completed
        task.toggle_complete()
        assert task.completed != original_status
        print("✓ Task completion toggle works")
        
        # Test serialization
        task_dict = task.to_dict()
        restored_task = Task.from_dict(task_dict)
        assert restored_task.id == task.id
        assert restored_task.title == task.title
        print("✓ Task serialization works")
        
        return True
    except Exception as e:
        print(f"✗ Task model test failed: {e}")
        return False

def test_task_service():
    """Test TaskService functionality."""
    print("\nTesting TaskService...")
    try:
        from services.task_service import TaskService
        
        # Use temporary file for testing
        with tempfile.NamedTemporaryFile(suffix='.json', delete=False) as tmp_file:
            temp_file_path = tmp_file.name
        
        try:
            service = TaskService(temp_file_path)
            
            # Test create task
            task1 = service.create_task("Test Task 1", "Description 1")
            assert task1.id == 1
            assert len(service.get_all_tasks()) == 1
            print("✓ Task creation works")
            
            # Test get tasks
            all_tasks = service.get_all_tasks()
            assert len(all_tasks) == 1
            assert all_tasks[0].title == "Test Task 1"
            print("✓ Task retrieval works")
            
            # Test update task
            updated_task = service.update_task(1, title="Updated Task 1")
            assert updated_task.title == "Updated Task 1"
            print("✓ Task update works")
            
            # Test toggle completion
            toggled_task = service.toggle_task_completion(1)
            assert toggled_task.completed == True
            print("✓ Task completion toggle works")
            
            # Test search
            task2 = service.create_task("Another Task", "Different description")
            search_results = service.search_tasks("another")
            assert len(search_results) == 1
            assert search_results[0].id == 2
            print("✓ Task search works")
            
            # Test statistics
            stats = service.get_task_count()
            assert stats["total"] == 2
            assert stats["completed"] == 1
            assert stats["active"] == 1
            print("✓ Task statistics work")
            
            # Test delete
            deleted = service.delete_task(1)
            assert deleted == True
            assert len(service.get_all_tasks()) == 1
            print("✓ Task deletion works")
            
        finally:
            # Clean up temp file
            if os.path.exists(temp_file_path):
                os.unlink(temp_file_path)
        
        return True
    except Exception as e:
        print(f"✗ TaskService test failed: {e}")
        return False

def run_tests():
    """Run all tests."""
    print("=" * 50)
    print("TODO CONSOLE APP - TEST SUITE")
    print("=" * 50)
    
    tests = [
        test_imports,
        test_task_model,
        test_task_service
    ]
    
    passed = 0
    total = len(tests)
    
    for test in tests:
        if test():
            passed += 1
    
    print("\n" + "=" * 50)
    print(f"TEST RESULTS: {passed}/{total} tests passed")
    
    if passed == total:
        print("🎉 All tests passed! The application is ready to use.")
        return True
    else:
        print("❌ Some tests failed. Please check the errors above.")
        return False

if __name__ == "__main__":
    success = run_tests()
    sys.exit(0 if success else 1)