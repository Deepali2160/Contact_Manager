package com.yash.contactmanager.serviceimpl;
import com.yash.contactmanager.dao.ContactDao;
import com.yash.contactmanager.daoimpl.ContactDaoImpl;
import com.yash.contactmanager.model.Contact;
import com.yash.contactmanager.service.ContactService;

import java.util.List;

public class ContactServiceImpl implements ContactService{
    private ContactDao contactDao;
    public ContactServiceImpl()
    {
        contactDao = new ContactDaoImpl();
    }

    @Override
    public boolean addContact(Contact contact)
    {
        //business logic validation
        return contactDao.addContact(contact);
    }

    @Override
    public List<Contact> getContactsByUserId(int userId) {
        return contactDao.getContactsByUserId(userId);
    }

    @Override
    public Contact getContactById(int contactId) {
        return contactDao.getContactById(contactId);
    }

    @Override
    public boolean updateContact(Contact contact) {
        return contactDao.updateContact(contact);
    }

    @Override
    public boolean deleteContact(int contactId) {
        return contactDao.deleteContact(contactId);
    }

    @Override
    public List<Contact> getUpcomingReminders(int userId) {
        return contactDao.getUpcomingReminders(userId);
    }

    @Override
    public boolean deleteMultipleContacts(List<Integer> contactIds) {
        return contactDao.deleteMultipleContacts(contactIds);
    }

    @Override
    public List<Contact> getContactsByIds(List<Integer> contactIds) {
        return contactDao.getContactsByIds(contactIds);
    }

    @Override
    public List<Contact> getContactsByUserIdSorted(int userId, String sortBy, String sortOrder) {
        return contactDao.getContactsByUserIdSorted(userId, sortBy, sortOrder);
    }

    @Override
    public int getContactCountByUserId(int userId) {
        return contactDao.getContactCountByUserId(userId);
    }

    @Override
    public int getFavoriteCountByUserId(int userId) {
        return contactDao.getFavoriteCountByUserId(userId);
    }

    @Override
    public List<Contact> getRecentContacts(int userId, int limit) {
        return contactDao.getRecentContacts(userId, limit);
    }
}
