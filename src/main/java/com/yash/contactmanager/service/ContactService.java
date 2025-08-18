package com.yash.contactmanager.service;

import com.yash.contactmanager.model.Contact;
import java.util.List;
public interface ContactService {
    boolean addContact(Contact contact);
    List<Contact> getContactsByUserId(int userId);
    Contact getContactById(int contactId);
    boolean updateContact(Contact contact);
    boolean deleteContact(int contactId);
    List<Contact> getUpcomingReminders(int userId);
    boolean deleteMultipleContacts(List<Integer> contactIds);
    List<Contact> getContactsByIds(List<Integer> contactIds);
    List<Contact> getContactsByUserIdSorted(int userId, String sortBy, String sortOrder);
    int getContactCountByUserId(int userId);
    int getFavoriteCountByUserId(int userId);
    List<Contact> getRecentContacts(int userId, int limit);
}
